import 'package:flutter/material.dart';
import 'package:my_eagles/pages/home/authenticate/authenticate.dart';
import 'package:my_eagles/pages/home/navigation.dart';
import 'package:my_eagles/models/app_user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Navigation();
    }
  }
}
