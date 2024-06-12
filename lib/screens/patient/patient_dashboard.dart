// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/api_service.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/models/news.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class PatientDashbord extends StatefulWidget {
  final User user;

  const PatientDashbord({required this.user});

  @override
  _PatientDashbordState createState() => _PatientDashbordState();
}

class _PatientDashbordState extends State<PatientDashbord> {
  List<News>? news;
  bool isLoading = true;
  final ApiService apiService = ApiService('https://alexsandr52-database-management-graduate-work-4add.twc1.net'); // Замените YOUR_BASE_URL на ваш URL

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      final newsList = await apiService.fetchNews();
      setState(() {
        news = newsList;
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
            SliverPadding(
              padding: const EdgeInsets.only(top: 10),
              sliver: SliverToBoxAdapter(
                child: ProfileCard(user: widget.user),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 10), // Добавленное расстояние
            ),
            if (isLoading)
              SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (news != null)
              SliverList.separated(
                itemBuilder: (context, index) => NewsBox(news: news![index]),
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: news!.length,
              )
            else
              SliverToBoxAdapter(
                child: Center(child: Text('No news available')),
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