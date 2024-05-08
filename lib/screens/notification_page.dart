// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => NnotificationPageState();
}

class NnotificationPageState extends State<NotificationPage> {
  static const Color constBackgroundColor = Color(0xffe2ecec);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: constBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CustomBox(
                child:
                    CastomNotification(onTapFunction: () {}, title: 'title')),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
