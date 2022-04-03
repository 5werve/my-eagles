import 'package:flutter/material.dart';
import 'package:my_eagles/services/auth.dart';
import 'package:my_eagles/shared/constants.dart';
import 'package:my_eagles/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
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
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: (val) => val!.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),
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
                    child:
                        Text('Sign In', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ]),
              ),
            ),
          );
  }
}
