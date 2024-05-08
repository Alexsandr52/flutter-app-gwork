// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => DdoctorDashboardState();
}

class DdoctorDashboardState extends State<DoctorDashboard> {
  static const Color constBackgroundColor = Color(0xffe2ecec);

  User alex = User(
      birthdate: '18.06.2004',
      name: 'Alexsander',
      surname: 'Polyanskiy',
      email: 'ak.gek@gmail.com',
      role: Roles.patient);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constBackgroundColor,
        appBar: CustomAppBar(),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            SizedBox(height: 10),
            ProfileCard(user: alex),
            SizedBox(height: 20),
            PatientCard(patient: alex),
          ],
        ));
  }
}
