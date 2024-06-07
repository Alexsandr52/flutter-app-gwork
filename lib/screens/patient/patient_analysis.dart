import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/api_service.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class AnalysisPage extends StatelessWidget {
  final apiService = ApiService('https://alexsandr52-database-management-graduate-work-4add.twc1.net');
  final User user;
  AnalysisPage({required this.user});

  @override
  Widget build(BuildContext context) {
    
    var analysis = () async {
    try {
      List<dynamic> imageInfo = await apiService.getImageInfoById(user.id);
      print(imageInfo);
      return imageInfo;
    } catch (e) {
      print('Failed to load image info: $e');
      rethrow;
    }
  };

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
            SliverList.separated(
              itemBuilder: (context, index) {
                return ReportCard(
                  patient: true,
                  analysis: analysis_list[index],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 20);
              },
              itemCount: analysis_list.length,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        patient: true,
        pageIndex: 1,
      ),
    );
  }
}
