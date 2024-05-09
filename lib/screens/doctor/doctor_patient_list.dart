// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class DoctorPatientList extends StatefulWidget {
  final List? patients;

  const DoctorPatientList({super.key, this.patients});

  @override
  State<DoctorPatientList> createState() => DdoctorPatientListState();
}

class DdoctorPatientListState extends State<DoctorPatientList> {
  static const Color constBackgroundColor = Color(0xffe2ecec);

  List patients = [];

  @override
  void initState() {
    if (widget.patients != null) {
      patients = widget.patients!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constBackgroundColor,
        appBar: CustomAppBar(title: 'Пациенты'),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return PatientCard(patient: patients[index]);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: patients.length),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 1));
  }
}
