// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class DoctorDashboard extends StatefulWidget {
  final List? news;
  final User? user;

  const DoctorDashboard({this.news, this.user});

  @override
  State<DoctorDashboard> createState() => DdoctorDashboardState();
}

class DdoctorDashboardState extends State<DoctorDashboard> {
  User user = User(
      id: 0,
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
    if (widget.news != null) {
      pageObj.addAll(widget.news!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themedata.constBackgroundColor,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          slivers: [
            // SliverList(delegate: Sliver)
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ProfileCard(user: user),
            )),
            SliverList.separated(
              itemBuilder: (context, index) {
                return NewsBox(news: pageObj[index]);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: pageObj.length,
            )
          ],
          // child: Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          // ProfileCard(user: user)
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(pageIndex: 0),
    );
  }
}
