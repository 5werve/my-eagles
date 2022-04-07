import 'package:flutter/material.dart';
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
  final controllerTo = TextEditingController();
  final controllerSubject = TextEditingController();
  final controllerMessage = TextEditingController();

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
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10.0),
          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: textInputDecoration,
          ),
        ],
      );

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
            padding: EdgeInsets.all(16.0),
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
                  child: Text('Send'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red[900],
                      minimumSize: Size.fromHeight(50.0),
                      textStyle:
                          TextStyle(fontSize: 20.0, color: Colors.white)))
            ])));
  }
}
