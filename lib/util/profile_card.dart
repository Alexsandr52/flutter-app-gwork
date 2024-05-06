// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {

  final String username; // Имя пользователя
  final String status;
  final String phone;
  final String email;
  final String selfInfo;
  final int age;
   
  static const Color constBackgroundColor = Color(0xffe2ecec);
  static const Color navBarsColor = Color(0xff089bab);
  static const Color boxesColor = Color(0xffffffff);

  // Конструктор с аргументом username и значением по умолчанию "Имя пользователя"
  const ProfileCard({
    this.username = 'Имя пользователя',
    this.status = 'Пациент',
    this.phone = '-',
    this.email = '-',
    this.selfInfo = '-',
    this.age = 0
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: boxesColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 4.0),
            blurRadius: 6.0,
          ),
        ]
      ),
      // elevation: 4,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:Column(
          children: [Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // Фотография заглушка
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: navBarsColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(
                  Icons.person,
                  size: 70,
                  color: constBackgroundColor,
                ),
              ),
              SizedBox(width: 16), // Промежуток между фотографией и полями информации
              
              // Поля информации
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Имя пользователя, переданное в аргументах
                    Text(
                      username,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Дополнительные поля
                    Text(
                      'Пациент:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4), // Промежуток между заголовком полями и полями

                    // Поля на выбор
                    Text('Возраст: ${age}', overflow: TextOverflow.ellipsis,),
                    Text('Телефон: ${phone}', overflow: TextOverflow.ellipsis,),
                    Text('Email: ${email}', overflow: TextOverflow.ellipsis,),
                    Text('О себе: ${selfInfo}', overflow: TextOverflow.ellipsis,),

                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20,),   
          InkWell(
              onTap: (){},
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: navBarsColor,
                  borderRadius: BorderRadius.circular(35),
                ),
                  child: Center(
                    child: Text('Изменить', style: TextStyle(
                      color: boxesColor,
                      fontSize: 20,
                      ),
                    ),
                  ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
