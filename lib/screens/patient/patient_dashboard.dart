// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/models/news.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class PatientDashbord extends StatelessWidget {
  final User user;
  final List? news;

  const PatientDashbord({super.key, required this.user, this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themedata.constBackgroundColor,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  ProfileCard(user: user),
                  SizedBox(height: 10),
                ],
              ),
            ),
            if (news != null)
              SliverList.separated(
                  itemBuilder: (context, index) {
                    return NewsBox(news: news![index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: news!.length)
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        patient: true,
        pageIndex: 0,
      ),
    );
    ;
  }
}
