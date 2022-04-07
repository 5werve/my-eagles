// Wrapper widget to pass ScheduleObject stream to the update schedule form

import 'package:flutter/material.dart';
import 'package:my_eagles/models/app_user.dart';
import 'package:my_eagles/models/schedule_object.dart';
import 'package:my_eagles/pages/home/schedule_change_form.dart';
import 'package:my_eagles/services/database.dart';
import 'package:provider/provider.dart';

class ScheduleChange extends StatefulWidget {
  const ScheduleChange({Key? key}) : super(key: key);

  @override
  State<ScheduleChange> createState() => _ScheduleChangeState();
}

class _ScheduleChangeState extends State<ScheduleChange> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    return StreamProvider<List<ScheduleObject>>.value(
        value: DatabaseService(uid: user.uid).userSchedule,
        initialData: const [],
        child: const ScheduleChangeForm());
  }
}
