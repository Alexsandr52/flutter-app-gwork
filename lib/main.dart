// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/screens/auth/auth_form.dart';
import 'package:gwork_flutter_application_1/screens/auth/login_form.dart';
import 'package:gwork_flutter_application_1/screens/doctor/doctor_dashboard.dart';
import 'package:gwork_flutter_application_1/screens/notification_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const Color constBackgroundColor = Color(0xffe2ecec);
  static const Color navBarsColor = Color(0xff089bab);
  static const Color boxesColor = Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 4,
            foregroundColor: Colors.white,
            backgroundColor: navBarsColor,
            disabledBackgroundColor: constBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            textStyle: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.normal),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            side: BorderSide.none,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: DoctorDashboard(),
      routes: {
        '/login': (context) => LoginForm(),
        '/auth': (context) => AuthForm(),
        '/home': (context) => DoctorDashboard(),
        '/notification': (context) => NotificationPage(),
      },
    );
  }
}
