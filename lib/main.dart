// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gwork_flutter_application_1/pages/home_page.dart';
import 'package:gwork_flutter_application_1/pages/auth_form.dart';

void main() {
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: AuthForm(),
      home: HomePage(),
      // theme: ThemeData(primarySwatch: Colors.Color(0xff089bab)),
    );
  }
}