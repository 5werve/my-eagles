import 'package:flutter/material.dart';
import 'package:my_eagles/pages/navigation.dart';
import 'package:my_eagles/pages/loading.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/navigation',
    routes: {
      '/': (context) => Loading(),
      '/navigation': (context) => Navigation(),
    },
  ));
}
