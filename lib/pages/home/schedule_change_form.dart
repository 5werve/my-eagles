// Form to change user's schedule

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_eagles/models/app_user.dart';
import 'package:my_eagles/models/schedule_object.dart';
import 'package:my_eagles/pages/home/report_bugs.dart';
import 'package:my_eagles/services/auth.dart';
import 'package:my_eagles/services/database.dart';
import 'package:my_eagles/shared/constants.dart';
import 'package:my_eagles/shared/loading.dart';
import 'package:provider/provider.dart';

class ScheduleChangeForm extends StatefulWidget {
  const ScheduleChangeForm({Key? key}) : super(key: key);

  @override
  State<ScheduleChangeForm> createState() => _ScheduleChangeFormState();
}

class _ScheduleChangeFormState extends State<ScheduleChangeForm> {
  final _formKey = GlobalKey<FormState>();
  bool initialized = true;

  // Form values
  final List<String> _currentClassNames = [];
  final List<String> _currentClassTeachers = [];
  final List<String> _currentClassRooms = [];

  @override
  Widget build(BuildContext context) {
    // Get object dependencies
    final user = Provider.of<AppUser>(context);
    final AuthService _auth = AuthService();
    // Get schedule objects to pre-fill text fields
    final scheduleItems = Provider.of<List<ScheduleObject>>(context);

    // Fill form values with initial values
    if (scheduleItems.isNotEmpty && initialized) {
      for (int i = 0; i < 8; i++) {
        _currentClassNames.add(scheduleItems[i].className);
        _currentClassTeachers.add(scheduleItems[i].classTeacher);
        _currentClassRooms.add(scheduleItems[i].classRoom);
      }
      initialized = false;
    }

    // Funciton to create form field for each class in the schedule
    List<Widget> formBuilder(List<ScheduleObject> schedule) {
      List<Widget> formWidgets = [];
      formWidgets.add(const SizedBox(height: 15.0));
      formWidgets.add(const Text(
        'Update your schedule:',
        style: TextStyle(
            fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
      ));
      formWidgets.add(const SizedBox(height: 20.0));
      for (int i = 0; i < 8; i++) {
        formWidgets.add(Text(
          'Period $i',
          style: const TextStyle(fontSize: 13.0, color: Colors.white),
        ));
        formWidgets.add(const SizedBox(height: 15.0));
        formWidgets.add(TextFormField(
          initialValue: schedule[i].className,
          decoration: textInputDecoration.copyWith(hintText: 'Class name'),
          validator: (val) => val!.isEmpty ? 'Please enter a class name' : null,
          onChanged: (val) => setState(() => _currentClassNames[i] = val),
        ));
        formWidgets.add(const SizedBox(height: 10.0));
        formWidgets.add(TextFormField(
          initialValue: schedule[i].classTeacher,
          decoration: textInputDecoration.copyWith(hintText: 'Teacher name'),
          validator: (val) =>
              val!.isEmpty ? 'Please enter a teacher name' : null,
          onChanged: (val) => setState(() {
            _currentClassTeachers[i] = val;
          }),
        ));
        formWidgets.add(const SizedBox(height: 10.0));
        formWidgets.add(TextFormField(
          initialValue: schedule[i].classRoom,
          decoration: textInputDecoration.copyWith(hintText: 'Classroom'),
          validator: (val) => val!.isEmpty ? 'Please enter a classroom' : null,
          onChanged: (val) => setState(() => _currentClassRooms[i] = val),
        ));
        formWidgets.add(const SizedBox(height: 15.0));
        if (i != 7) {
          formWidgets.add(const Divider(color: Colors.white));
        }
        formWidgets.add(const SizedBox(height: 15.0));
      }
      formWidgets.add(const SizedBox(height: 30.0));
      formWidgets.add(
        // Button to validate form fields and update database
        RaisedButton(
          color: Colors.red[900],
          child: const Text(
            'Update',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              List<ScheduleObject> schedule = [];
              for (int i = 0; i < 8; i++) {
                schedule.add(ScheduleObject(
                    className: _currentClassNames[i],
                    classTeacher: _currentClassTeachers[i],
                    classRoom: _currentClassRooms[i],
                    classPeriod: i.toString()));
              }
              await DatabaseService(uid: user.uid).updateUserData(schedule);
              Navigator.pop(context);
            }
          },
        ),
      );
      formWidgets.add(const SizedBox(height: 20.0));
      return formWidgets;
    }

    if (scheduleItems.isNotEmpty) {
      // Returns body of form
      return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: const Text(
            'Centennial HS',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          centerTitle: false,
          elevation: 0.0,
          leading: const Image(
            image: AssetImage('assets/centennial-logo.png'),
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.report_problem_outlined,
                color: Colors.white,
              ),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReportBugs()));
              },
            ),
            FlatButton.icon(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: const Text('Logout',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Align(
            alignment: Alignment.center,
            child: ListView(children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: Column(children: formBuilder(scheduleItems)),
              )
            ]),
          ),
        ),
      );
    } else {
      return const Loading();
    }
  }
}
