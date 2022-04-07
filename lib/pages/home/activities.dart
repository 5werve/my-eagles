// Lists school extracurricular activities using a list of cards

import 'package:flutter/material.dart';
import 'package:my_eagles/models/activity_model.dart';

class Activities extends StatefulWidget {
  const Activities({Key? key}) : super(key: key);

  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  // Generate list of activities using ActivityModel model
  List<ActivityModel> activities = [
    ActivityModel(
        name: 'Key Club',
        description:
            '* A student-led volunteering organization that aims to build leadership and service in youth.\n* Advisor: Jennifer Morgan.\n* Meeting dates: Every 3rd Thursday of the month at 7:40am in the Community Room'),
    ActivityModel(
        name: 'FBLA',
        description:
            "* Organization that builds the future business leaders of America through relevant career-training opportunities.\n* Advisor: Michael Miller.\n* Meeting dates: Every other Wednesday in Miller's room."),
    ActivityModel(
        name: 'Boys Tennis',
        description:
            '* We hit fast balls and have fun!\n* Coach: Jimmy Mei.\n* Meeting dates: After school in Room 176.')
  ];

  @override
  Widget build(BuildContext context) {
    // Display each object in the activities list using a list view to generate cards for each activity
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                  color: Colors.grey[800],
                  margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(activities[index].name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(activities[index].description,
                          style: TextStyle(color: Colors.grey[400])),
                    ),
                  ),
                ),
              );
            },
            itemCount: activities.length,
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
    );
  }
}
