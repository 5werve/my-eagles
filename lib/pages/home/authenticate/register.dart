// Form to register new user

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_eagles/shared/constants.dart';
import 'package:my_eagles/shared/loading.dart';
import 'package:my_eagles/services/auth.dart';

// Refer to comments for sign in page; this file is very similar to the former
class Register extends StatefulWidget {
  final Function toggleView;
  // ignore: use_key_in_widget_constructors
  const Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // Text field states
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
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
                  FlatButton.icon(
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label: const Text('Sign In',
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
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: (val) => val!.length < 6
                        ? 'Enter a password 6+ characters long'
                        : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth
                            .registerWithEmailandPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Please supply a valid email';
                            loading = false;
                          });
                        }
                      }
                    },
                    color: Colors.red[900],
                    child: const Text('Register',
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
