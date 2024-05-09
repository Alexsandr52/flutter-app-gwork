// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class DoctorPatientList extends StatefulWidget {
  const DoctorPatientList({super.key});

  @override
  State<DoctorPatientList> createState() => DdoctorPatientListState();
}

class DdoctorPatientListState extends State<DoctorPatientList> {
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
        appBar: CustomAppBar(title: 'Пациенты'),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            SizedBox(height: 20),
            PatientCard(patient: alex),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 1));
  }
}
