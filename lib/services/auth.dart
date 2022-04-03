import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_eagles/models/app_user.dart';
import 'package:my_eagles/models/schedule_object.dart';
import 'package:my_eagles/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on Firebase's User obj
  AppUser? _appUserFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_appUserFromFirebaseUser);
  }

  // sign in with email and password
  Future signInUserWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _appUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // create a new document for the use with the uid
      List<ScheduleObject> schedule = [];
      for (int i = 0; i < 8; i++) {
        schedule.add(ScheduleObject(
            className: 'Class name',
            classPeriod: i.toString(),
            classRoom: '176',
            classTeacher: 'Teacher name'));
      }

      await DatabaseService(uid: user!.uid).updateUserData(schedule);

      return _appUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
