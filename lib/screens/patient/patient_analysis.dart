// ignore_for_file: prefer_const_constructors, use_super_parameters, use_rethrow_when_possible, avoid_print

import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/api_service.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/models/analysis.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class AnalysisPage extends StatelessWidget {
  final ApiService apiService = ApiService('https://alexsandr52-database-management-graduate-work-4add.twc1.net');
  final User user;

  AnalysisPage({Key? key, required this.user}) : super(key: key);

  List<Analysis> parseAnalysis(List<dynamic> imageInfo, int patientId) {
    return imageInfo.map((item) => Analysis.fromJson(item, patientId)).toList();
  }

  Future<List<Analysis>> fetchAnalysis() async {
    try {
      List<dynamic> imageInfo = await apiService.getImageInfoById(user.id);
      return parseAnalysis(imageInfo, user.id);
    } catch (e) {
      print('Failed to load image info: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themedata.constBackgroundColor,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder<List<Analysis>>(
          future: fetchAnalysis(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Данные не найдены'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Данные не найдены'));
            } else {
              var analysisList = snapshot.data!;
              return CustomScrollView(
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
                  SliverList.separated(
                    itemBuilder: (context, index) {
                      return ReportCard(
                        patient: true,
                        analysis: analysisList[index],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemCount: analysisList.length,
                  ),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        patient: true,
        pageIndex: 1,
      ),
    );
  }
}
