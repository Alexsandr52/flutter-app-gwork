// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/models/news.dart';
import 'package:gwork_flutter_application_1/models/notif.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/screens/auth/auth_form.dart';
import 'package:gwork_flutter_application_1/screens/auth/login_form.dart';
import 'package:gwork_flutter_application_1/screens/doctor/doctor_dashboard.dart';
import 'package:gwork_flutter_application_1/screens/doctor/doctor_patient_list.dart';
import 'package:gwork_flutter_application_1/screens/notification_page.dart';
import 'package:gwork_flutter_application_1/screens/patient/patient_analysis.dart';
import 'package:gwork_flutter_application_1/screens/patient/patient_dashboard.dart';
import 'package:gwork_flutter_application_1/screens/settings.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    String title = 'Новость';
    String text =
        'Ошибка "The instance member \'user\' can\'t be accessed in an initializer" возникает потому, что переменная user инициализируется в то же самое время, когда она используется в инициализаторе news.';
    List news = [
      News(
        title: title,
        text: text,
      ),
      News(
          title: title,
          text: text,
          imgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3UHJsjR5JKiuYmu8oki6BkzbQGnzzQ2FdWZQH38s-hg&s'),
      News(
          title: title,
          text: text,
          imgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3UHJsjR5JKiuYmu8oki6BkzbQGnzzQ2FdWZQH38s-hg&s'),
      News(
          title: title,
          text: text,
          imgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3UHJsjR5JKiuYmu8oki6BkzbQGnzzQ2FdWZQH38s-hg&s'),
      News(
          title: title,
          text: text,
          imgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3UHJsjR5JKiuYmu8oki6BkzbQGnzzQ2FdWZQH38s-hg&s'),
    ];
    User patient = User(
      name: 'Олег',
      surname: 'Приветов',
      birthdate: '10/09/2003',
      email: 'example@gmail.com',
      role: Roles.patient,
      phone: '+79888885674',
      id: 10,
      selfInfo:
          'В основной части кода вызывается функция find_min_four_digit_number(), чтобы найти наименьшее четырехзначное число, которое может появиться на экране в результате работы автомата, и результат выводится на экран.',
    );
    User doctor = User(
        id: 23,
        name: 'Александр',
        surname: 'Полянский',
        email: 'gek@gmail.com',
        role: Roles.doctor);

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
                fontWeight: FontWeight.normal),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            side: BorderSide.none,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      // home: DoctorDashboard(
      //   news: news,
      //   user: doctor,
      // ),
      // home: SettingsPage(),
      home: PatientDashbord(user: doctor, news: news),
      routes: {
        '/login': (context) => LoginForm(),
        '/auth': (context) => AuthForm(),
        '/notification': (context) => NotificationPage(
              notifArr: [
                NotificationObj(title: 'Увед', text: text, author: 'ME')
              ],
            ),
        '/docHome': (context) => DoctorDashboard(
              user: doctor,
              news: news,
            ),
        '/docPatientList': (context) => DoctorPatientList(
              patients: [patient, patient, patient, patient, patient, patient],
            ),
        '/patientHome': (context) => PatientDashbord(
              user: doctor,
              news: news,
            ),
        '/patientAnalisis': (context) => AnalisisPage(user: doctor),
      },
    );
  }
}
