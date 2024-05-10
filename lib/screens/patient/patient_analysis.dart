import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/models/analysis.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class AnalisisPage extends StatelessWidget {
  final User user;

  const AnalisisPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    Analysis analysis = Analysis(
        imgUrl:
            'https://zdorovie-feodosia.ru/upload/iblock/8a4/3k43vn9brvm2jmjyxob1dt0ndzipjqfr.webp',
        patientId: 10,
        text:
            'Рентген верхней конечности в Феодосии - записаться на рентген-исследование в медцентр «ЗДОРОВЬЕ»',
        title: 'Заголовок');
    List analysis_list = [
      analysis,
      analysis,
      analysis,
      analysis,
      analysis,
      analysis,
      analysis
    ];

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
                    patient: true, analysis: analysis_list[index]);
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
