// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gwork_flutter_application_1/screens/auth/auth_form.dart';
import 'package:gwork_flutter_application_1/screens/auth/login_form.dart';
import 'package:gwork_flutter_application_1/screens/doctor/doctor_dashboard.dart';
import 'package:gwork_flutter_application_1/screens/doctor/doctor_patient_list.dart';
import 'package:gwork_flutter_application_1/screens/notification_page.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  final String title = 'Новость';
  final String text =
      'Ошибка "The instance member \'user\' can\'t be accessed in an initializer" возникает потому, что переменная user инициализируется в то же самое время, когда она используется в инициализаторе news.';

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
      home: DoctorDashboard(news: [
        NewsBox(
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvSx0FbtCgMryLllm4D5vT1T0GGzJK1qQdzXuJfYI_oA&s',
          title: title,
          text: text,
        ),
        NewsBox(
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRguHCFY2jxLVPhf_-7EFFXZ65w9LIMmpVsMcrI5lWMVw&s',
          title: title,
          text: text,
        ),
        NewsBox(
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvSx0FbtCgMryLllm4D5vT1T0GGzJK1qQdzXuJfYI_oA&s',
          title: title,
          text: text,
        ),
        NewsBox(
          title: title,
          text: text,
        )
      ]),
      routes: {
        '/login': (context) => LoginForm(),
        '/auth': (context) => AuthForm(),
        '/docHome': (context) => DoctorDashboard(),
        '/docPatientList': (context) => DoctorPatientList(),
      },
    );
  }
}
