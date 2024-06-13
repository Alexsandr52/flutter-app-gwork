import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/screens/auth/auth_form.dart';
import 'package:gwork_flutter_application_1/screens/auth/login_form.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key); // Исправлено объявление конструктора

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Themedata.navBarsColor, elevation: 4, // Использование onPrimary для текста
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
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
      },
    );
  }
}