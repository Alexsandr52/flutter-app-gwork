
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// footer
class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  static const Color constBackgroundColor = Color(0xffe2ecec);
  static const Color navBarsColor = Color(0xff089bab);
  static const Color boxesColor = Color(0xffffffff); 
  
  AppBottomNavigationBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Главная',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_chart_outlined_rounded),
          label: 'Анализы',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline_rounded),
          label: 'Чат',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: navBarsColor,
      onTap: (value){print(value);},
    );
  }
}
// header
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  static const Color constBackgroundColor = Color(0xffe2ecec);
  static const Color navBarsColor = Color(0xff089bab);
  static const Color boxesColor = Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: navBarsColor,
      title: Text('Injury_Insight'),
      // leading: Icon(Icons.menu, color: Colors.white,),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.notifications_on_outlined, color: Colors.white,))],
      centerTitle: true,
      titleTextStyle: TextStyle(color: boxesColor, fontSize: 20),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
// profile card
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
// default box for build
class CustomBox extends StatelessWidget {
  final Widget child;

  CustomBox({required this.child});

  static const Color boxesColor = Color(0xffffffff);
  static const Color constBackgroundColor = Color(0xffe2ecec);

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

      child: Padding(
        padding: EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
// button
class AppButton extends StatelessWidget {

  final String title;
  final Function onTapFunction;
   
  static const Color constBackgroundColor = Color(0xffe2ecec);
  static const Color navBarsColor = Color(0xff089bab);
  static const Color boxesColor = Color(0xffffffff);

  // Конструктор с аргументом username и значением по умолчанию "Имя пользователя"
  AppButton({required this.onTapFunction, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: navBarsColor,
          borderRadius: BorderRadius.circular(35),
        ),
          child: Center(
            child: Text(title, style: TextStyle(
              color: boxesColor,
              fontSize: 20,
              ),
            ),
          ),
      ),
    );
  }
}
// report card for analyses
class ReportCard extends StatelessWidget {
  final String text;
  final String title;
  final String doctor;
  final ImageProvider? image;
  final String imageUrl;

  static const Color constBackgroundColor = Color(0xffe2ecec);
  static const Color navBarsColor = Color(0xff089bab);
  static const Color boxesColor = Color(0xffffffff);

  ReportCard({
    required this.title,
    required this.text,
    required this.doctor,
    this.image,
    this.imageUrl = '',
  });

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Container(
            alignment: Alignment.center,
            child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          ),
          
          SizedBox(height: 12,),

          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(150),
                    child: image != null
                      ? Image(image: image!, fit: BoxFit.cover)
                      : Image.network(imageUrl, fit: BoxFit.cover),
                  ),
              ),
          ),
          SizedBox(height: 12,),
          
          Text(text, style: TextStyle(fontSize: 14)),
          
          Container(
            child: Row(
              children: [
                Text('Др: ' + doctor, style: TextStyle(fontWeight: FontWeight.bold)),
                // SizedBox(width: 15,),
                TextButton(
                  onPressed: (){}, 
                  child: 
                    Row(
                      children: [
                        Text('Поддержка'), 
                        Icon(Icons.contact_support_outlined)
                      ]
                    ),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(navBarsColor), // Цвет текста кнопки
                  ),
                )
            ],)
          )
        ],
      ),
    );
  }
}



