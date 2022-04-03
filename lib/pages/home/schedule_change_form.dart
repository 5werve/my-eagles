import 'package:flutter/material.dart';
import 'package:my_eagles/models/app_user.dart';
import 'package:my_eagles/models/schedule_object.dart';
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    final scheduleItems = Provider.of<List<ScheduleObject>>(context);

    // form values
    List<String>? _currentClassNames;
    List<String>? _currentClassTeachers;
    List<String>? _currentClassRooms;

    Widget buildFormField(List<ScheduleObject>? schedule) {
      List<Widget> formSection = [];
      for (int i = 0; i < 8; i++) {
        formSection.add(Text(
          'Period $i',
          style: TextStyle(fontSize: 13.0),
        ));
        formSection.add(SizedBox(height: 8.0));
        formSection.add(TextFormField(
          initialValue: schedule![i].className,
          decoration: textInputDecoration,
          validator: (val) => val!.isEmpty ? 'Please enter a class name' : null,
          onChanged: (val) => setState(() => _currentClassNames![i] = val),
        ));
        formSection.add(SizedBox(height: 5.0));
        formSection.add(TextFormField(
          initialValue: schedule[i].classTeacher,
          decoration: textInputDecoration,
          validator: (val) =>
              val!.isEmpty ? 'Please enter a teacher name' : null,
          onChanged: (val) => setState(() => _currentClassTeachers![i] = val),
        ));
        formSection.add(SizedBox(height: 5.0));
        formSection.add(TextFormField(
          initialValue: schedule[i].classRoom,
          decoration: textInputDecoration,
          validator: (val) => val!.isEmpty ? 'Please enter a class room' : null,
          onChanged: (val) => setState(() => _currentClassRooms![i] = val),
        ));
        formSection.add(SizedBox(height: 25.0));
      }
      return ListView(children: formSection);
    }

    for (int i = 0; i < 8; i++) {
      _currentClassNames?.add(scheduleItems[i].className);
      _currentClassTeachers?.add(scheduleItems[i].classTeacher);
      _currentClassRooms?.add(scheduleItems[i].classRoom);
    }

    if (scheduleItems.isNotEmpty) {
      return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              'Update your schedule',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            buildFormField(scheduleItems),
            SizedBox(height: 30.0),
            RaisedButton(
              color: Colors.red[900],
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  List<ScheduleObject> schedule = [];
                  for (int i = 0; i < 8; i++) {
                    schedule.add(ScheduleObject(
                        className: _currentClassNames![i],
                        classTeacher: _currentClassTeachers![i],
                        classRoom: _currentClassRooms![i],
                        classPeriod: i.toString()));
                  }
                  await DatabaseService(uid: user.uid).updateUserData(schedule);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      );
    } else {
      return const Loading();
    }
  }
}
