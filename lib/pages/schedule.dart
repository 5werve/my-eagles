import 'package:flutter/material.dart';
import 'package:my_eagles/services/schedule_object.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  static List<ScheduleObject> scheduleItems = [
    ScheduleObject(
        className: "Name",
        classTeacher: "Teacher",
        classRoom: 100,
        classPeriod: 0),
    ScheduleObject(
        className: "Name",
        classTeacher: "Teacher",
        classRoom: 100,
        classPeriod: 0),
    ScheduleObject(
        className: "Name",
        classTeacher: "Teacher",
        classRoom: 100,
        classPeriod: 0),
    ScheduleObject(
        className: "Name",
        classTeacher: "Teacher",
        classRoom: 100,
        classPeriod: 0),
    ScheduleObject(
        className: "Name",
        classTeacher: "Teacher",
        classRoom: 100,
        classPeriod: 0),
    ScheduleObject(
        className: "Name",
        classTeacher: "Teacher",
        classRoom: 100,
        classPeriod: 0),
    ScheduleObject(
        className: "Name",
        classTeacher: "Teacher",
        classRoom: 100,
        classPeriod: 0),
    ScheduleObject(
        className: "Name",
        classTeacher: "Teacher",
        classRoom: 100,
        classPeriod: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: scheduleItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              color: Colors.grey[700],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                    child: Text(
                      scheduleItems[index].className,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                    child: Text(
                      "Period: " + scheduleItems[index].classPeriod.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.0),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                    child: Text(
                      "Teacher: " + scheduleItems[index].classTeacher,
                      style: const TextStyle(fontSize: 15.0),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                    child: Text(
                      "Room: " + scheduleItems[index].classRoom.toString(),
                      style: const TextStyle(fontSize: 17.0),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                ],
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.grey[900],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dynamic result = Navigator.pushNamed(context, '/createSchedule',
              arguments: scheduleItems);
        },
      ),
    );
  }
}
