import 'package:flutter/material.dart';
import 'package:my_eagles/models/app_user.dart';
import 'package:my_eagles/models/teacher.dart';
import 'package:my_eagles/pages/home/email_form.dart';
import 'package:my_eagles/services/database.dart';
import 'package:my_eagles/shared/loading.dart';
import 'package:provider/provider.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      color: Colors.grey[900],
      child: StreamBuilder<List<Teacher>>(
          stream: DatabaseService(uid: user.uid).teacherEmails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Teacher>? teachers = snapshot.data;
              return Scaffold(
                body: ListView.builder(
                  itemCount: teachers!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3.0, horizontal: 4.0),
                      child: Card(
                        color: Colors.grey[700],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5.0),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                              child: SelectableText(
                                teachers[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                              child: SelectableText(
                                teachers[index].email,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                backgroundColor: Colors.grey[900],
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EmailForm()));
                  },
                  icon: const Icon(Icons.send),
                  label: const Text('Send Email'),
                ),
              );
            } else {
              return const Loading();
            }
          }),
    );
  }
}
