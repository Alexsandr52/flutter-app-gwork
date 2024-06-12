// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/api_service.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/models/news.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class DoctorDashboard extends StatefulWidget {
  final List? news;
  final User? user;

  const DoctorDashboard({this.news, this.user});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  User user = User(
    id: 0,
    birthdate: 'Ошибка',
    name: 'Ошибка',
    surname: 'Ошибка',
    email: 'Ошибка',
    role: Roles.patient,
  );

  List<News> pageObj = [];
  bool isLoading = true;
  final ApiService apiService = ApiService('https://alexsandr52-database-management-graduate-work-4add.twc1.net'); // Замените YOUR_BASE_URL на ваш URL

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      user = widget.user!;
    }
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      final newsList = await apiService.fetchNews();
      setState(() {
        pageObj = newsList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Обработка ошибок
      print('Failed to load news: $e');
    }
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ProfileCard(user: user),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 10), // Добавленное расстояние
            ),
            if (isLoading)
              SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (pageObj.isNotEmpty)
              SliverList.separated(
                itemBuilder: (context, index) {
                  return NewsBox(news: pageObj[index]);
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: pageObj.length,
              )
            else
              SliverToBoxAdapter(
                child: Center(child: Text('No news available')),
              ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBarDoctor(pageIndex: 0),
    );
  }
}