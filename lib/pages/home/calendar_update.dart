import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_eagles/services/auth.dart';
import 'package:my_eagles/shared/constants.dart';
import 'package:intl/intl.dart';

class CalendarUpdate extends StatefulWidget {
  const CalendarUpdate({Key? key}) : super(key: key);

  @override
  State<CalendarUpdate> createState() => _CalendarUpdateState();
}

class _CalendarUpdateState extends State<CalendarUpdate> {
  final _formKey = GlobalKey<FormState>();
  final calendarReference = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();

  // form values
  String? _currentSubject;
  String? _currentStartDate;
  String? _currentEndDate;

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15.0),
              const Text(
                'Add calendar event:',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration:
                    textInputDecoration.copyWith(hintText: 'Event name'),
                validator: (val) =>
                    val!.isEmpty ? 'Please enter an event name' : null,
                onChanged: (val) => setState(() => _currentSubject = val),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: "Start date (format 'dd/MM/yyyy HH:mm:ss')"),
                validator: (val) {
                  try {
                    DateFormat('dd/MM/yyyy HH:mm:ss').parse(val ?? '');
                    return null;
                  } catch (FormatException) {
                    return "Please enter a date with the format 'dd/MM/yyyy HH:mm:ss'";
                  }
                },
                onChanged: (val) => setState(() => _currentStartDate = val),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: "End date (format 'dd/MM/yyyy HH:mm:ss')"),
                validator: (val) {
                  try {
                    DateFormat('dd/MM/yyyy HH:mm:ss').parse(val ?? '');
                    if (DateFormat('dd/MM/yyyy HH:mm:ss')
                        .parse(_currentEndDate!)
                        .isBefore(DateFormat('dd/MM/yyyy HH:mm:ss')
                            .parse(_currentStartDate!))) {
                      return "Please enter a date after the start date";
                    } else {
                      return null;
                    }
                  } catch (FormatException) {
                    return "Please enter a date with the format 'dd/MM/yyyy HH:mm:ss'";
                  }
                },
                onChanged: (val) => setState(() => _currentEndDate = val),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.red[900],
                child: const Text(
                  'Add Event',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await calendarReference
                        .collection("CalendarAppointmentCollection")
                        .doc(_currentSubject)
                        .set({
                      'Subject': '$_currentSubject',
                      'StartTime': '$_currentStartDate',
                      'EndTime': '$_currentEndDate'
                    });
                    ;
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
