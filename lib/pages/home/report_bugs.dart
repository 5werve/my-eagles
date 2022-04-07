// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_eagles/services/auth.dart';
import 'package:my_eagles/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportBugs extends StatefulWidget {
  const ReportBugs({Key? key}) : super(key: key);

  @override
  State<ReportBugs> createState() => _ReportBugsState();
}

class _ReportBugsState extends State<ReportBugs> {
  final AuthService _auth = AuthService();
  final controllerBugName = TextEditingController();
  final controllerDescription = TextEditingController();

  Widget buildTextField({
    required String title,
    required TextEditingController controller,
    int maxLines = 1,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: textInputDecoration,
          ),
        ],
      );

  Future launchEmail({
    required String bugName,
    required String description,
  }) async {
    final url =
        'mailto:vuminhmatthew@gmail.com?subject=${Uri.encodeFull(bugName)}&body=${Uri.encodeFull(description)}';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

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
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              buildTextField(title: 'Bug name', controller: controllerBugName),
              const SizedBox(height: 16.0),
              buildTextField(
                  title: 'Description',
                  controller: controllerDescription,
                  maxLines: 8),
              const SizedBox(height: 32.0),
              ElevatedButton(
                  onPressed: () => launchEmail(
                        bugName: controllerBugName.text,
                        description: controllerDescription.text,
                      ),
                  child: const Text('Report Bug'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red[900],
                      minimumSize: const Size.fromHeight(50.0),
                      textStyle:
                          const TextStyle(fontSize: 20.0, color: Colors.white)))
            ])));
  }
}
