// Display user's schedule with button to redirect to schedule change form. User can also share their schedule.

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_eagles/models/schedule_object.dart';
import 'package:my_eagles/models/app_user.dart';
import 'package:my_eagles/pages/home/schedule_change.dart';
import 'package:my_eagles/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:my_eagles/services/database.dart';
import 'package:social_share/social_share.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  // Create string to share schedule
  String shareScheduleText = 'Check Out My Schedule:\n\n';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    // Getting stream of ScheduleObjects to display
    return StreamBuilder<List<ScheduleObject>>(
        stream: DatabaseService(uid: user.uid).userSchedule,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ScheduleObject>? scheduleItems = snapshot.data;
            return Scaffold(
              appBar:
                  AppBar(backgroundColor: Colors.grey[900], actions: <Widget>[
                // Share button that generates the string to share schedule
                FlatButton.icon(
                  icon: const Icon(
                    Icons.share_outlined,
                    color: Colors.white,
                  ),
                  label: const Text('Share',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: () {
                    setState(() {});
                    int period = 0;
                    for (ScheduleObject object in scheduleItems!) {
                      shareScheduleText +=
                          'Class name: ${object.className}\nPeriod: $period\nTeacher: ${object.classTeacher}\nRoom: ${object.classRoom}\n----------------------------------\n';
                      period++;
                    }
                    // Sharing the string via the device's default share menu
                    SocialShare.shareOptions(shareScheduleText);
                  },
                ),
              ]),
              // Display a list of the user's classes, forming their schedule
              body: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 15.0),
                color: Colors.grey[900],
                child: Scaffold(
                  body: ListView.builder(
                    itemCount: scheduleItems!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 4.0),
                        child: Card(
                          color: Colors.grey[700],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 2.0),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    4.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  scheduleItems[index].className,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    4.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  "Period: " +
                                      scheduleItems[index]
                                          .classPeriod
                                          .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    4.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  "Teacher: " +
                                      scheduleItems[index].classTeacher,
                                  style: const TextStyle(fontSize: 15.0),
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    4.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  "Room: " +
                                      scheduleItems[index].classRoom.toString(),
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
                  // Button to redirect user to update schedule form
                  floatingActionButton: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScheduleChange()));
                    },
                    icon: const Icon(Icons.settings_outlined),
                    label: const Text('Change'),
                  ),
                ),
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
