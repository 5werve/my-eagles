// Form to login user

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_eagles/services/auth.dart';
import 'package:my_eagles/shared/constants.dart';
import 'package:my_eagles/shared/loading.dart';

class SignIn extends StatefulWidget {
  // Passing function to toggle between sign in and register
  final Function toggleView;
  // ignore: use_key_in_widget_constructors
  const SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Getting authentication service object
  final AuthService _auth = AuthService();
  // Getting form key
  final _formKey = GlobalKey<FormState>();
  // Variable to set loading status
  bool loading = false;

  // Text field states
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    // Show loading or the form based on value of loading
    return loading
        ? const Loading()
        : Scaffold(
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
                  // Button to toggle between sign in and register
                  FlatButton.icon(
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label: const Text('Register',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: () {
                      widget.toggleView();
                    },
                  ),
                ]),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              // Form widget
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  const SizedBox(height: 20.0),
                  // Text field for email
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  // Text field for password
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    // Code to check if password is greater than 6 characters long
                    validator: (val) => val!.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  // Button to validate form fields and login user
                  RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth
                            .signInUserWithEmailandPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Could not sign in with those credentials';
                            loading = false;
                          });
                        }
                      }
                    },
                    color: Colors.red[900],
                    child: const Text('Sign In',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ]),
              ),
            ),
          );
  }
}
