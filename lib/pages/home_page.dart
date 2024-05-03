// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Auth extends StatefulWidget{
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  static const Color constBackgroundColor = Color(0xffe2ecec);
  static const Color navBarsColor = Color(0xff089bab);
  static const Color boxesColor = Color(0xffffffff);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: constBackgroundColor,
        
        appBar: AppBar(
          backgroundColor: navBarsColor,
          title: Text('HealApp'),
          elevation: 0,
          leading: Icon(Icons.menu),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person_2_outlined))],
        ),
        
        // body: Center(
        //   child: Container(
        //     // child: ListView,
        //     height: 300,
        //     width: 300,
        //     decoration: BoxDecoration(
        //       color: boxesColor, // используйте color здесь
        //       borderRadius: BorderRadius.all(Radius.circular(15.0)),
        //     ),
        //   ),
        // ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: double.infinity, // максимальная ширина
              ),
              decoration: BoxDecoration(
                color: boxesColor,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              // child: , // вставьте свой виджет содержимого сюда
            ),
          ),
        ),

    );      
  }
}