// Form to send email to teacher

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_eagles/pages/home/report_bugs.dart';
import 'package:my_eagles/services/auth.dart';
import 'package:my_eagles/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({Key? key}) : super(key: key);

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final AuthService _auth = AuthService();
  // Create text field controllers
  final controllerTo = TextEditingController();
  final controllerSubject = TextEditingController();
  final controllerMessage = TextEditingController();

  // Function to create text field
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

  // Function to open email client and fill in fields
  Future launchEmail({
    required String toEmail,
    required String subject,
    required String message,
  }) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';
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
            IconButton(
              icon: const Icon(
                Icons.report_problem_outlined,
                color: Colors.white,
              ),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReportBugs()));
              },
            ),
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
        // Build email form
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              buildTextField(title: 'To', controller: controllerTo),
              const SizedBox(height: 16.0),
              buildTextField(title: 'Subject', controller: controllerSubject),
              const SizedBox(height: 16.0),
              buildTextField(
                  title: 'Message', controller: controllerMessage, maxLines: 8),
              const SizedBox(height: 32.0),
              ElevatedButton(
                  onPressed: () => launchEmail(
                        toEmail: controllerTo.text,
                        subject: controllerSubject.text,
                        message: controllerMessage.text,
                      ),
                  child: const Text('Send'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red[900],
                      minimumSize: const Size.fromHeight(50.0),
                      textStyle:
                          const TextStyle(fontSize: 20.0, color: Colors.white)))
            ])));
  }
}
