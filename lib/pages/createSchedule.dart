import 'package:flutter/material.dart';
import 'package:my_eagles/services/schedule_object.dart';

class createSchedule extends StatefulWidget {
  const createSchedule({Key? key}) : super(key: key);

  @override
  _createScheduleState createState() => _createScheduleState();
}

class _createScheduleState extends State<createSchedule> {
  static List<ScheduleObject> scheduleItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.red[900],
      title: const Text('Edit Schedule',
          style: TextStyle(color: Colors.white, letterSpacing: 1.5)),
      centerTitle: false,
      elevation: 0.0,
    ));
  }
}
