// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/api_service.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/models/analysis.dart';
import 'package:gwork_flutter_application_1/models/news.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/models/notif.dart';
import 'package:gwork_flutter_application_1/screens/doctor/doctor_dashboard.dart';
import 'package:gwork_flutter_application_1/screens/doctor/doctor_patient_list.dart';
import 'package:gwork_flutter_application_1/screens/notification_page.dart';
import 'package:gwork_flutter_application_1/screens/patient/patient_analysis.dart';
import 'package:gwork_flutter_application_1/screens/patient/patient_dashboard.dart';
import 'package:gwork_flutter_application_1/screens/settings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationPage()),
                  );
                },
                icon: Icon(
                  Icons.notifications_on_outlined,
                  color: Colors.white,
                ),
              ),
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

  const ProfileCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Themedata.boxesColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Фотография заглушка
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Themedata.navBarsColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 70,
                    color: Themedata.constBackgroundColor,
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
            SizedBox(height: 10),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton.icon(
                onPressed: () {},
                label: Text('Изменить'),
                icon: Icon(Icons.edit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Кастомная карточка для любых виджетов
class CustomBox extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color color;

  CustomBox({required this.child, this.onTap, this.color = Themedata.boxesColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
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

  Future<void> _sendEmail(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'ak.polyanskiy@gmail.com',
      queryParameters: {
        'subject': 'Запрос на поддержку',
        'body': 'Опишите вашу проблему здесь...',
        'attachment': analysis.imgUrl, // Предполагается, что imgUrl содержит ссылку на изображение
      },
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось открыть приложение почты')),
      );
    }
  }

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
                'Статус обработки "${analysis.title!}"',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(height: 10),
          Stack(
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    analysis.imgUrl,
                    fit: BoxFit.none,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          if (analysis.text != null)
            Text(analysis.text!, style: TextStyle(fontSize: 14)),
          Container(
            child: Row(
              children: [
                Text('Yolo V8', style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                TextButton(
                  onPressed: () => _sendEmail(context),
                  child: Row(
                    children: [
                      Text('Поддержка'),
                      Icon(Icons.contact_support_outlined),
                    ],
                  ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Themedata.navBarsColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Уведомление
class CustomNotification extends StatelessWidget {
  final NotificationObj notif;

  CustomNotification({required this.notif});

  factory CustomNotification.fromMap(Map<String, dynamic> data) {
    return CustomNotification(
      notif: NotificationObj(
        title: data['notification_title'] ?? 'Уведомление',
        text: data['notification_text'],
        time: data['notification_time'],
      ),
    );
  }

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
                  notif.title ?? "",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                if (notif.text != null)
                  Text(
                    notif.text!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                SizedBox(height: 5),
                if (notif.time != null)
                  Text(
                    notif.time!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationDetailsScreen(notificationObj: notif),
          ),
        );
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
          if (notificationObj.time != null)
            Text(notificationObj.time!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// Карточка пациента
class PatientCard extends StatelessWidget {
  final User patient;

  const PatientCard({required this.patient, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientDetailsScreen(patient: patient),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${patient.name} ${patient.surname ?? ''}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'Дата рождения: ${patient.birthdate ?? 'Не указано'}',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 5),
              Text(
                'Email: ${patient.email}',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 5),
              Text(
                'Телефон: ${patient.phone ?? 'Не указано'}',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 5),
              Text(
                'Доп. информация: ${patient.selfInfo ?? 'Не указано'}',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Страница с деталями для пациента
class PatientDetailsScreen extends StatefulWidget {
  final User patient;

  PatientDetailsScreen({required this.patient});

  @override
  _PatientDetailsScreenState createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  final ApiService apiService = ApiService('https://alexsandr52-database-management-graduate-work-4add.twc1.net');
  final ImagePicker _picker = ImagePicker();

  Future<List<Analysis>> fetchAnalysis(int patientId) async {
    try {
      List<dynamic> imageInfo = await apiService.postImageInfoByIdDoctor(patientId);
      return parseAnalysis(imageInfo, patientId);
    } catch (e) {
      print('Failed to load image info: $e');
      throw e;
    }
  }

  List<Analysis> parseAnalysis(List<dynamic> imageInfo, int patientId) {
    return imageInfo.map((item) => Analysis.fromJson(item, patientId)).toList();
  }

  Future<void> _uploadImage(BuildContext context) async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      try {
        await apiService.uploadImage(widget.patient.id, imageFile);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image uploaded successfully')),
          );
          setState(() {});
        }
      } catch (e) {
        print('Failed to upload image: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload image')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Пациент id ${widget.patient.id}'),
        actions: [
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () => _uploadImage(context),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.patient.name} ${widget.patient.surname ?? ''}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Почта: ${widget.patient.email}'),
                  SizedBox(height: 10),
                  if (widget.patient.birthdate != null)
                    Text('Дата рождения: ${widget.patient.birthdate}'),
                  SizedBox(height: 10),
                  if (widget.patient.phone != null)
                    Text('Тел: ${widget.patient.phone}'),
                  SizedBox(height: 10),
                  if (widget.patient.selfInfo != null)
                    Text('О себе: ${widget.patient.selfInfo}'),
                  SizedBox(height: 20),
                  Divider(thickness: 2),
                  Text(
                    'Анализы',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            FutureBuilder<List<Analysis>>(
              future: fetchAnalysis(widget.patient.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Ошибка загрузки данных ${snapshot.error}')),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Нет данных для отображения')),
                  );
                } else {
                  List<Analysis> analysisList = snapshot.data!;
                  return SliverList.separated(
                    itemBuilder: (context, index) {
                      return ReportCard(analysis: analysisList[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20);
                    },
                    itemCount: analysisList.length,
                  );
                }
              },
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
  User? user;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.pageIndex;
    _isPatient = widget.patient;
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      setState(() {
        user = User.fromJson(jsonDecode(userData));
      });
    }
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
    if (user == null) {
      print('User is not loaded yet');
      return;
    }
    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PatientDashbord(user: user!)),
          (route) => false,
        );
        break;
      case 1:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AnalysisPage(user: user!)),
          (route) => false,
        );
        break;
      case 2:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage(user: user!)),
          (route) => false,
        );
        break;
    }
  }

  void _navigateToDoctorPage(int index) {
    if (user == null) {
      print('User is not loaded yet');
      return;
    }
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
              Expanded(
                child: Text(
                  news.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          if (news.imgUrl != null)
            SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  news.imgUrl!,
                  fit: BoxFit.cover,
                  height: 150,
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

class CustomBottomNavigationBarDoctor extends StatefulWidget {
  final int pageIndex;

  const CustomBottomNavigationBarDoctor({required this.pageIndex});

  @override
  _CustomBottomNavigationBarDoctorState createState() =>
      _CustomBottomNavigationBarDoctorState();
}

class _CustomBottomNavigationBarDoctorState
    extends State<CustomBottomNavigationBarDoctor> {
  late int _selectedIndex;
  User? user; 

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      setState(() {
        user = User.fromJson(jsonDecode(userData));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.pageIndex;
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      _navigateToDoctorPage(index);
    }
  }

  void _navigateToDoctorPage(int index) {
    _loadUser();
    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DoctorDashboard(user: user)),
          (route) => false,
        );
        break;
      case 1:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DoctorPatientList(),),
          (route) => false,
        );
        break;
      case 2:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage(user: user!)),
          (route) => false,
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
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
