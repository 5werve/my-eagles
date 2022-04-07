// Returns authenticate or navigation widget based on login status of user

import 'package:flutter/material.dart';
import 'package:my_eagles/pages/home/authenticate/authenticate.dart';
import 'package:my_eagles/pages/home/navigation.dart';
import 'package:my_eagles/models/app_user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Getting user object from stream
    final user = Provider.of<AppUser?>(context);

    // Return either Home or Authenticate widget depending on login status
    if (user == null) {
      return const Authenticate();
    } else {
      return const Navigation();
    }
  }
}
