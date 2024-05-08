// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gwork_flutter_application_1/models/users.dart';

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
      onTap: (value) {
        print(value);
      },
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
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/notification');
            },
            icon: Icon(
              Icons.notifications_on_outlined,
              color: Colors.white,
            ))
      ],
      centerTitle: true,
      titleTextStyle: TextStyle(color: boxesColor, fontSize: 20),
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// profile card
class ProfileCard extends StatelessWidget {
  final User user;

  static const Color constBackgroundColor = Color(0xffe2ecec);
  static const Color navBarsColor = Color(0xff089bab);
  static const Color boxesColor = Color(0xffffffff);

  // Конструктор с аргументом username и значением по умолчанию "Имя пользователя"
  const ProfileCard({required this.user});

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
          ]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Row(
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
              SizedBox(width: 16),
              // Поля информации
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Имя пользователя, переданное в аргументах
                    Text(
                      user.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Дополнительные поля
                    if (user.role != null)
                      Text(
                        'Роль: ${user.role == Roles.patient ? 'Пациент' : 'Доктор'}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (user.birthdate != null)
                      Text(
                        'Возраст: ${user.birthdate}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (user.phone != null)
                      Text(
                        'Телефон: ${user.phone}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (user.email != null)
                      Text(
                        'Email: ${user.email}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (user.selfInfo != null)
                      Text(
                        'О себе: ${user.selfInfo}',
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton.icon(
              onPressed: () {},
              label: Text('Изменить'),
              icon: Icon(Icons.edit),
            ),
          )
        ]),
      ),
    );
  }
}

// default box for build
class CustomBox extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  CustomBox({required this.child, this.onTap});

  static const Color boxesColor = Color(0xffffffff);
  static const Color constBackgroundColor = Color(0xffe2ecec);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
            ]),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: child,
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
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            alignment: Alignment.center,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
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
          SizedBox(
            height: 12,
          ),
          Text(text, style: TextStyle(fontSize: 14)),
          Container(
              child: Row(
            children: [
              Text('Др: ' + doctor,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              // SizedBox(width: 15,),
              TextButton(
                onPressed: () {},
                child: Row(children: [
                  Text('Поддержка'),
                  Icon(Icons.contact_support_outlined)
                ]),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      navBarsColor), // Цвет текста кнопки
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}

class CastomNotification extends StatelessWidget {
  final String title;
  final Function onTapFunction;

  static const Color constBackgroundColor = Color(0xffe2ecec);
  static const Color navBarsColor = Color(0xff089bab);
  static const Color boxesColor = Color(0xffffffff);

  // Конструктор с аргументом username и значением по умолчанию "Имя пользователя"
  CastomNotification({required this.onTapFunction, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(title),
          Spacer(),
          TextButton(
            onPressed: () {},
            child: Text('Удалить'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(navBarsColor),
            ),
          )
        ],
      ),
    );
  }
}

class PatientCard extends StatelessWidget {
  final User patient;

  const PatientCard({required this.patient});

  static const Color boxesColor = Color(0xffffffff);
  static const Color constBackgroundColor = Color(0xffe2ecec);

  @override
  Widget build(BuildContext context) {
    return CustomBox(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PatientDetailsScreen(patient: patient)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${patient.name} ${patient.surname}'),
            Text('${patient.birthdate}'),
            // Text(),
          ],
        ));
  }
}

class PatientDetailsScreen extends StatelessWidget {
  final User patient;

  const PatientDetailsScreen({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${patient.name} ${patient.surname}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Почта: ${patient.email}'),
            if (patient.birthdate != null)
              Text('Дата рождения: ${patient.birthdate}'),
            if (patient.phone != null) Text('Тел: ${patient.phone}'),
            if (patient.selfInfo != null)
              Text('Дата рождения: ${patient.selfInfo}'),

            // Добавьте здесь другие поля, которые хотите отобразить
          ],
        ),
      ),
    );
  }
}
