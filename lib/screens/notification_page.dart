// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/models/notif.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class NotificationPage extends StatefulWidget {
  final List? notifArr;
  NotificationPage({this.notifArr});

  @override
  State<NotificationPage> createState() => NnotificationPageState();
}

class NnotificationPageState extends State<NotificationPage> {
  static const Color constBackgroundColor = Color(0xffe2ecec);

  List notifArr = [];

  @override
  void initState() {
    if (widget.notifArr != null) {
      notifArr = widget.notifArr!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Уведомления',
        notificationIcon: false,
      ),
      backgroundColor: constBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return CustomNotification(notif: notifArr[index]);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: notifArr.length,
        ),
      ),
    );
  }
}
