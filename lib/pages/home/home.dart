import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:my_eagles/models/meeting.dart';
import 'package:my_eagles/pages/home/calendar.dart';
import 'package:my_eagles/shared/loading.dart';

import 'event_tile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Meeting>? events;
  final calendarReference = FirebaseFirestore.instance;

  @override
  void initState() {
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    super.initState();
  }

  Future<void> getDataFromFireStore() async {
    var snapshotsValue = await calendarReference
        .collection("CalendarAppointmentCollection")
        .get();

    List<Meeting> list = snapshotsValue.docs
        .map((e) => Meeting(
            eventName: e.data()['Subject'],
            from:
                DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['StartTime']),
            to: DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['EndTime']),
            background: Colors.white,
            isAllDay: false))
        .toList();
    setState(() {
      events = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (events != null) {
      return Scaffold(
        body: ListView(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(15.0),
                color: Colors.grey[800],
                child: Text(
                    '${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('MMMM').format(DateTime.now())} ${DateFormat('d').format(DateTime.now())}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("TODAY'S EVENTS",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DateTime now = DateTime.now();
                DateTime? eventDate = events![index].from;
                bool isBefore = ((now.year <= eventDate!.year) &&
                    (now.month <= eventDate.month) &&
                    (now.day <= eventDate.day));
                bool isAfter = ((now.year >= eventDate.year) &&
                    (now.month >= eventDate.month) &&
                    (now.day >= eventDate.day));
                if (isBefore && isAfter) {
                  return EventTile(event: events![index]);
                } else {
                  return SizedBox(height: 0.0);
                }
              },
              itemCount: events!.length,
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("BELL SCHEDULE",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            Container(
                margin: EdgeInsets.all(15.0),
                child: const Image(image: AssetImage('assets/schedule.png'))),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("LUNCH MENU",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            Container(
                margin: EdgeInsets.all(15.0),
                child: const Image(image: AssetImage('assets/menu.png'))),
          ],
        ),
        backgroundColor: Colors.grey[900],
      );
    } else {
      return const Loading();
    }
  }
}
