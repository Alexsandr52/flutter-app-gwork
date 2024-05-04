// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/util/profile_card.dart';
import 'package:gwork_flutter_application_1/util/nav_bar.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color constBackgroundColor = Color(0xffe2ecec);
  static const Color navBarsColor = Color(0xff089bab);
  static const Color boxesColor = Color(0xffffffff);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: constBackgroundColor,
        
        appBar: AppBar(
          backgroundColor: navBarsColor,
          title: Text('Injury_Insight'),
          leading: Icon(Icons.menu, color: Colors.white,),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person, color: Colors.white,))],
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        
        
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 10,),
                ProfileCard(username: 'Alexsander', age: 19, status: 'Пациент', phone: '+7 988 000-57-86', email: 'ak.polyanskiy@gmail.com', selfInfo: 'Студент 4 курса',),
                SizedBox(height: 10,),
                ProfileCard(username: 'Alexsander', age: 19, status: 'Пациент', phone: '+7 988 000-57-86', email: 'ak.polyanskiy@gmail.com', selfInfo: 'Студент 4 курса',),
              ],
            ),
          ),

        bottomNavigationBar: AppBottomNavigationBar(currentIndex: 0)
    );      
  }
}