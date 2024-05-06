// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/util/widgets.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color constBackgroundColor = Color(0xffe2ecec);
  // static const Color navBarsColor = Color(0xff089bab);
  // static const Color boxesColor = Color(0xffffffff);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: constBackgroundColor,
        
        appBar: CustomAppBar(),
        
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 10,),
                
                ProfileCard(username: 'Alexsander', age: 19, status: 'Пациент', phone: '+7 988 000-57-86', email: 'ak.polyanskiy@gmail.com', selfInfo: 'Студент 4 курса',),
                
                SizedBox(height: 10,),
                
                ReportCard(doctor: 'Polyanskiy A.K', text: 'Просто текст заглушка который наглядно показывает как выглядит карточка с анализами', title: 'Название для изображения', imageUrl: 'https://i.pinimg.com/564x/a9/f5/3a/a9f53af65250f92bf12c2cab73374926.jpg',),
                SizedBox(height: 10,),
                
                ReportCard(doctor: 'Polyanskiy A.K', text: 'Просто текст заглушка который наглядно показывает как выглядит карточка с анализами', title: 'Название для изображения', imageUrl: 'https://i.pinimg.com/564x/a9/f5/3a/a9f53af65250f92bf12c2cab73374926.jpg',),
                SizedBox(height: 10,),
                
                ReportCard(doctor: 'Polyanskiy A.K', text: 'Просто текст заглушка который наглядно показывает как выглядит карточка с анализами', title: 'Название для изображения', imageUrl: 'https://i.pinimg.com/564x/a9/f5/3a/a9f53af65250f92bf12c2cab73374926.jpg',),
                SizedBox(height: 10,),
                
                ReportCard(doctor: 'Polyanskiy A.K', text: 'Просто текст заглушка который наглядно показывает как выглядит карточка с анализами', title: 'Название для изображения', imageUrl: 'https://i.pinimg.com/564x/a9/f5/3a/a9f53af65250f92bf12c2cab73374926.jpg',),
                SizedBox(height: 10,),
                
                ReportCard(doctor: 'Polyanskiy A.K', text: 'Просто текст заглушка который наглядно показывает как выглядит карточка с анализами', title: 'Название для изображения', imageUrl: 'https://i.pinimg.com/564x/a9/f5/3a/a9f53af65250f92bf12c2cab73374926.jpg',),

              ],
            ),
          ),

        bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0)
    );      
  }
}