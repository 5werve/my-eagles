import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_eagles/models/schedule_object.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference scheduleCollection =
      FirebaseFirestore.instance.collection('schedules');

  Future updateUserData(List<ScheduleObject> classes) async {
    int index = 0;
    Map<String, String> schedule = {};
    for (ScheduleObject classItem in classes) {
      schedule['className$index'] = classItem.className;
      schedule['classTeacher$index'] = classItem.classTeacher;
      schedule['classRoom$index'] = classItem.classRoom;
      schedule['classPeriod$index'] = classItem.classPeriod;
      index++;
    }
    return await scheduleCollection.doc(uid).set(schedule);
  }

  // ScheduleObject from snapshot
  List<ScheduleObject> _scheduleObjectsFromSnapshot(DocumentSnapshot snapshot) {
    List<ScheduleObject> schedule = [];
    for (int i = 0; i < 8; i++) {
      schedule.add(ScheduleObject(
          className: snapshot['className$i'] ?? '',
          classTeacher: snapshot['classTeacher$i'] ?? '',
          classRoom: snapshot['classRoom$i'] ?? '',
          classPeriod: snapshot['classPeriod$i'] ?? ''));
    }

    return schedule;
  }

  // get user doc stream
  Stream<List<ScheduleObject>> get userSchedule {
    return scheduleCollection
        .doc(uid)
        .snapshots()
        .map(_scheduleObjectsFromSnapshot);
  }
}
