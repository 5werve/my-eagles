import 'package:flutter/material.dart';
import 'package:my_eagles/pages/home/authenticate/sign_in.dart';
import 'package:my_eagles/pages/home/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  // Function to toggle between register and sign in screen
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    // Return sign in or register page based on value of showSignIn
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
