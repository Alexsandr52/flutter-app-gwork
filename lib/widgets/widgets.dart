// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/models/analysis.dart';
import 'package:gwork_flutter_application_1/models/news.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/models/notif.dart';

// Верхний бар
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool notificationIcon;

  CustomAppBar({this.title, this.notificationIcon = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Themedata.navBarsColor,
      title: title == null ? null : Text(title!),
      actions: notificationIcon
          ? [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/notification');
                    // Navigator.pushNamed(context, routeName)
                    // builder: (context) => NotificationPage(),
                  },
                  icon: Icon(
                    Icons.notifications_on_outlined,
                    color: Colors.white,
                  ))
            ]
          : null,
      centerTitle: true,
      titleTextStyle: TextStyle(color: Themedata.boxesColor, fontSize: 20),
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// Карта профиля
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
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey,
        //     offset: Offset(0.0, 4.0),
        //     blurRadius: 6.0,
        //   ),
        // ],
      ),
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

// Кастомная карточка для любых виджетов
class CustomBox extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color color;

  CustomBox(
      {required this.child, this.onTap, this.color = Themedata.boxesColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //     offset: Offset(0.0, 4.0),
          //     blurRadius: 6.0,
          //   ),
          // ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}

// Карты для анализов
class ReportCard extends StatelessWidget {
  final Analysis analysis;
  final bool patient;

  ReportCard({required this.analysis, this.patient = false});

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      color: patient ? Themedata.boxesColor : Themedata.constBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (analysis.title != null)
            Container(
              alignment: Alignment.center,
              child: Text(
                analysis.title!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox.fromSize(
                size: Size.fromRadius(150),
                child: Image.network(analysis.imgUrl, fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          if (analysis.text != null)
            Text(analysis.text!, style: TextStyle(fontSize: 14)),
          Container(
              child: Row(
            children: [
              Text('Yolo V8', style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Row(children: [
                  Text('Поддержка'),
                  Icon(Icons.contact_support_outlined)
                ]),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Themedata.navBarsColor), // Цвет текста кнопки
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

// Уведомление
class CustomNotification extends StatelessWidget {
  final NotificationObj notif;

  // Конструктор с аргументом username и значением по умолчанию "Имя пользователя"
  CustomNotification({required this.notif});

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${notif.title}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                if (notif.text != null)
                  Text(
                    notif.text!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                SizedBox(
                  height: 5,
                ),
                if (notif.author != null)
                  Text(notif.author!,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          // Spacer(),
          TextButton(
            // TODO
            onPressed: () {},
            child: Text('Удалить'),
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(Themedata.navBarsColor),
            ),
          )
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NotificationDetailsScreen(notificationObj: notif)));
      },
    );
  }
}

// Страница для уведомления
class NotificationDetailsScreen extends StatelessWidget {
  final NotificationObj notificationObj;

  const NotificationDetailsScreen({required this.notificationObj});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        notificationIcon: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            '${notificationObj.title}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          if (notificationObj.text != null)
            Text(
              notificationObj.text!,
            ),
          SizedBox(
            height: 5,
          ),
          if (notificationObj.author != null)
            Text(notificationObj.author!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// Карточка пациента
class PatientCard extends StatelessWidget {
  final User patient;
  const PatientCard({required this.patient});

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
            Text(
              '${patient.name} ${patient.surname}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('${patient.birthdate}'),
            // Text(),
          ],
        ));
  }
}

// Страница с деталями для пациента
class PatientDetailsScreen extends StatelessWidget {
  final User patient;

  const PatientDetailsScreen({required this.patient});

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
      appBar: CustomAppBar(title: ''),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${patient.name} ${patient.surname}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Почта: ${patient.email}'),
                  SizedBox(height: 10),
                  if (patient.birthdate != null)
                    Text('Дата рождения: ${patient.birthdate}'),
                  SizedBox(height: 10),
                  if (patient.phone != null) Text('Тел: ${patient.phone}'),
                  SizedBox(height: 10),
                  if (patient.selfInfo != null)
                    Text('О себе: ${patient.selfInfo}'),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SliverList.separated(
              itemBuilder: (context, index) {
                return ReportCard(analysis: analysis_list[index]);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 20);
              },
              itemCount: analysis_list.length,
            ),
          ],
        ),
      ),
    );
  }
}

// Нижняя навигация
class CustomBottomNavigationBar extends StatefulWidget {
  final int pageIndex;
  final bool patient;

  const CustomBottomNavigationBar({required this.pageIndex, this.patient = false});

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _selectedIndex;
  late bool _isPatient;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.pageIndex;
    _isPatient = widget.patient;
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      if (_isPatient) {
        _navigateToPatientPage(index);
      } else {
        _navigateToDoctorPage(index);
      }
    }
  }

  void _navigateToPatientPage(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/patientHome');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/patientAnalysis');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/patientSettings');
        break;
      default:
        break;
    }
  }

  void _navigateToDoctorPage(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/docHome');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/docPatientList');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/docSettings');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _isPatient
          ? const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Главная',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.text_snippet_sharp),
                label: 'Анализы',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Настройки',
              ),
            ]
          : const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Главная',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_alt),
                label: 'Пациенты',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Настройки',
              ),
            ],
      currentIndex: _selectedIndex,
      selectedItemColor: Themedata.navBarsColor,
      onTap: _onItemTapped,
    );
  }
}

// Карточка для новостей и рекламы
class NewsBox extends StatelessWidget {
  // final String title;
  // final String text;
  // final bool? important;
  // final String? imageUrl;
  final News news;

  NewsBox({required this.news});

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (news.isImportant) Icon(Icons.label_important),
              Text(
                news.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 5),
          if (news.imgUrl != null)
            SizedBox(
              width:
                  double.infinity, // Ширина равна ширине родительского элемента
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Скругленные углы
                child: Image.network(
                  news.imgUrl!,
                  fit: BoxFit.cover, // Заполнение контейнера
                  height: 150, // Высота изображения
                ),
              ),
            ),
          SizedBox(height: 10),
          Text(news.text),
        ],
      ),
    );
  }
}
