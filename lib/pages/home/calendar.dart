import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_eagles/models/app_user.dart';
import 'package:my_eagles/models/meeting.dart';
import 'package:my_eagles/pages/home/calendar_update.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final List<Color> _colorCollection = <Color>[];
  MeetingDataSource? events;
  final List<String> options = <String>['Add', 'Delete'];
  final calendarReference = FirebaseFirestore.instance;
  Meeting? _selectedAppointment = null;

  @override
  void initState() {
    _initializeEventColor();
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

    final Random random = Random();
    List<Meeting> list = snapshotsValue.docs
        .map((e) => Meeting(
            eventName: e.data()['Subject'],
            from:
                DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['StartTime']),
            to: DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['EndTime']),
            background: _colorCollection[random.nextInt(9)],
            isAllDay: false))
        .toList();
    setState(() {
      events = MeetingDataSource(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user!.uid == '1yH7HKyV7KPWDOsXdNQB7MSZuGM2') {
      return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
              title: const Text('CHS Calendar'),
              backgroundColor: Colors.grey[900],
              actions: <Widget>[
                PopupMenuButton<String>(
                  icon: const Icon(Icons.settings),
                  itemBuilder: (BuildContext context) =>
                      options.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList(),
                  onSelected: (String value) {
                    if (value == 'Add') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CalendarUpdate()));
                      setState(() {
                        getDataFromFireStore();
                      });
                    } else if (value == "Delete") {
                      calendarReference
                          .collection('CalendarAppointmentCollection')
                          .doc(_selectedAppointment?.eventName)
                          .delete();
                      setState(() {
                        getDataFromFireStore();
                      });
                    }
                  },
                ),
                FlatButton.icon(
                  icon: const Icon(
                    Icons.refresh_outlined,
                    color: Colors.white,
                  ),
                  label: const Text('Refresh',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: () {
                    setState(() {
                      getDataFromFireStore();
                    });
                  },
                ),
              ]),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SfCalendar(
              view: CalendarView.month,
              initialDisplayDate: DateTime.now(),
              dataSource: events,
              monthViewSettings: const MonthViewSettings(
                showAgenda: true,
              ),
              onTap: calendarTapped,
            ),
          ));
    } else {
      return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
              title: const Text('CHS Calendar'),
              backgroundColor: Colors.grey[900],
              actions: <Widget>[
                FlatButton.icon(
                  icon: const Icon(
                    Icons.refresh_outlined,
                    color: Colors.white,
                  ),
                  label: const Text('Refresh',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: () {
                    setState(() {
                      getDataFromFireStore();
                    });
                  },
                ),
              ]),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SfCalendar(
              view: CalendarView.month,
              initialDisplayDate: DateTime.now(),
              dataSource: events,
              monthViewSettings: const MonthViewSettings(
                showAgenda: true,
              ),
              onTap: calendarTapped,
            ),
          ));
    }
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.agenda ||
        calendarTapDetails.targetElement == CalendarElement.appointment) {
      if (calendarTapDetails.appointments!.isNotEmpty) {
        final Meeting appointment = calendarTapDetails.appointments![0];
        _selectedAppointment = appointment;
      }
    }
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}
