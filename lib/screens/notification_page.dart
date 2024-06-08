import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/models/notif.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';
import 'package:gwork_flutter_application_1/api_service.dart'; // Импортируем ApiService

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  static const Color constBackgroundColor = Color(0xffe2ecec);
  List<NotificationObj>? notifArr; // Изменили тип списка

  @override
  void initState() {
    super.initState();
    _loadNotifications(); // Загружаем уведомления при инициализации страницы
  }

  Future<void> _loadNotifications() async {
    final apiService = ApiService('https://alexsandr52-database-management-graduate-work-4add.twc1.net'); // Инициализация ApiService
    try {
      final notifications = await apiService.getNotifications(); // Получаем уведомления из ApiService
      
      // Преобразуем список Map в список NotificationObj
      final notificationObjects = notifications.map((notification) {
        return NotificationObj(
          title: notification['notification_title'],
          text: notification['notification_text'],
          time: notification['notification_time'],
        );
      }).toList();
      
      setState(() {
        notifArr = notificationObjects;
      });
    } catch (e) {
      print('Failed to load notifications: $e');
      // Handle error
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Уведомления',
        notificationIcon: false,
      ),
      backgroundColor: constBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: notifArr == null
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (context, index) {
                  return CustomNotification(notif: notifArr![index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: notifArr!.length,
              ),
      ),
    );
  }
}
