// Main file

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_eagles/pages/wrapper.dart';
import 'package:my_eagles/services/auth.dart';
import 'models/app_user.dart';
import 'package:provider/provider.dart';

void main() async {
  // Code to initialize Flutter widgets
  WidgetsFlutterBinding.ensureInitialized();
  // Initializing app with Firebase
  await Firebase.initializeApp();
  // Create root widget
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create stream provider to get user login status
    return StreamProvider<AppUser?>.value(
      // Value of the stream is the AppUser model
      value: AuthService().user,
      initialData: null,
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
