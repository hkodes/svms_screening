import 'package:flutter/material.dart';
import 'package:svms_screening/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simplify VMS Screening',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: Homepage(),
    );
  }
}
