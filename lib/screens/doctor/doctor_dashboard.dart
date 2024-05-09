// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class DoctorDashboard extends StatefulWidget {
  final List? news;
  final User? user;

  DoctorDashboard({this.news, this.user});

  @override
  State<DoctorDashboard> createState() => DdoctorDashboardState();
}

class DdoctorDashboardState extends State<DoctorDashboard> {
  static const Color constBackgroundColor = Color(0xffe2ecec);

  User user = User(
      birthdate: 'Ошибка',
      name: 'Ошибка',
      surname: 'Ошибка',
      email: 'Ошибка',
      role: Roles.patient);

  List pageObj = [];

  @override
  void initState() {
    if (widget.user != null) {
      user = widget.user!;
    }
    pageObj.add(ProfileCard(user: user));
    if (widget.news != null) {
      pageObj.addAll(widget.news!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constBackgroundColor,
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return pageObj[index];
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemCount: pageObj.length),
      ),

      // body: ListView(
      //   padding: EdgeInsets.all(10),
      //   children: [
      //     SizedBox(height: 10),
      //     ProfileCard(user: alex),
      //     SizedBox(height: 20),
      //     PatientCard(patient: alex),
      //   ],
      // ),
      bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 0),
    );
  }
}
