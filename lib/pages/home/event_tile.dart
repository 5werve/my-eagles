import 'package:flutter/material.dart';
import 'package:my_eagles/models/meeting.dart';
import 'package:intl/intl.dart';

class EventTile extends StatelessWidget {
  final Meeting event;
  EventTile({required this.event});

  @override
  Widget build(BuildContext context) {
    String? eventName = event.eventName;
    DateTime? startDate = event.from;
    DateTime? endDate = event.to;
    String formattedStartDate =
        DateFormat('yyyy-MM-dd - hh:mm a').format(startDate!);
    String formattedEndDate =
        DateFormat('yyyy-MM-dd - hh:mm a').format(endDate!);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        color: Colors.grey[800],
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(eventName!, style: TextStyle(color: Colors.white)),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text('Starts: $formattedStartDate\nEnds: $formattedEndDate',
                style: TextStyle(color: Colors.grey[400])),
          ),
        ),
      ),
    );
  }
}
