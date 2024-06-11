// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
// import 'package:gwork_flutter_application_1/models/notif.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class SettingsPage extends StatelessWidget {

  final bool patient;

  const SettingsPage({super.key, this.patient = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Themedata.constBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomBox(
          child: ListView(
            children: [],
          ),
        ),
      ),
      bottomNavigationBar: patient 
        ? CustomBottomNavigationBar(pageIndex: 2, patient: patient)
        : CustomBottomNavigationBarDoctor(pageIndex: 2),
    );
  }
}
