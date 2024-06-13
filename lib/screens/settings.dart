// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/models/user.dart'; // Импортируем класс User
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  final User user; // Передаем пользователя в качестве параметра

  const SettingsPage({Key? key, required this.user}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _otherDataController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.name);
    _lastNameController = TextEditingController(text: widget.user.surname ?? '');
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone ?? '');
    _otherDataController = TextEditingController(text: widget.user.selfInfo ?? '');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _otherDataController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    // Здесь можно добавить логику сохранения изменений в базу данных или другое хранилище
    // Примерно так:
    // widget.user.name = _firstNameController.text;
    // widget.user.surname = _lastNameController.text;
    // widget.user.email = _emailController.text;
    // widget.user.phone = _phoneController.text;
    // widget.user.selfInfo = _otherDataController.text;
    // После сохранения изменений, возможно, потребуется обновить UI или перезагрузить страницу
    // Пока что пример сохранения данных показан для локальных изменений, реализация с сервером может отличаться
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Themedata.constBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomBox(
          child: ListView(
            children: [
              // Поля для ввода данных пользователя
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'Имя'),
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Фамилия'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Номер телефона'),
              ),
              TextFormField(
                controller: _otherDataController,
                decoration: InputDecoration(labelText: 'Другие персональные данные'),
              ),
              SizedBox(height: 20),
              // Кнопка сохранить
              ElevatedButton(
                onPressed: _saveChanges,
                child: Text('Сохранить'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Themedata.navBarsColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
              ),
              SizedBox(height: 20),
              // Кнопка выйти (пока что неактивная)
              OutlinedButton(
                onPressed: () {
                  // Действие при нажатии на кнопку выхода
                },
                child: Text('Выйти'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Themedata.navBarsColor, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: widget.user.role == Roles.patient
          ? CustomBottomNavigationBar(pageIndex: 2, patient: true)
          : CustomBottomNavigationBarDoctor(pageIndex: 2),
    );
  }
}
