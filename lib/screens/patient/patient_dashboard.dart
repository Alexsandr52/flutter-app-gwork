// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class PatientDashbord extends StatelessWidget {
  final User user;
  final List? news;

  const PatientDashbord({required this.user, this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themedata.constBackgroundColor,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: 10),
              sliver: SliverToBoxAdapter(
                child: ProfileCard(user: user),
              ),
            ),
            if (news != null)
              SliverList.separated(
                itemBuilder: (context, index) => NewsBox(news: news![index]),
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: news!.length,
              ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        patient: true,
        pageIndex: 0,
      ),
    );
  }
}
