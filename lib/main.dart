// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/screens/auth/auth_form.dart';
import 'package:gwork_flutter_application_1/screens/auth/login_form.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 4,
            foregroundColor: Colors.white,
            backgroundColor: Themedata.navBarsColor,
            disabledBackgroundColor: Themedata.constBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            side: BorderSide.none,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginForm(),
      routes: {
        '/login': (context) => LoginForm(),
        '/auth': (context) => AuthForm(),
        // '/patientHome': (context) => , // Разкомментируйте и добавьте виджет для главной страницы пациента
      },
    );
  }
}
