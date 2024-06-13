import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/api_service.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
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
  late ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.name);
    _lastNameController = TextEditingController(text: widget.user.surname ?? '');
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone ?? '');
    _otherDataController = TextEditingController(text: widget.user.selfInfo ?? '');

    _apiService = ApiService('https://alexsandr52-database-management-graduate-work-4add.twc1.net'); // Замените на ваш базовый URL
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

  void _saveChanges() async {
    try {
      var response = await _apiService.updateUserInfo(
        widget.user.id,
        newFirstName: _firstNameController.text.isNotEmpty ? _firstNameController.text : null,
        newLastName: _lastNameController.text.isNotEmpty ? _lastNameController.text : null,
        newEmail: _emailController.text.isNotEmpty ? _emailController.text : null,
        newPhoneNumber: _phoneController.text.isNotEmpty ? _phoneController.text : null,
        newPersonalData: _otherDataController.text.isNotEmpty ? _otherDataController.text : null,
      );
      if (response['error'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['error'])));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['response'] ?? 'Изменения сохранены')));
        // Возможно, обновите состояние или UI после успешного сохранения
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ошибка при сохранении изменений: $e')));
    }
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
                  Navigator.popAndPushNamed(context, '/login');
                },
                child: Text('Выйти'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Themedata.navBarsColor,
                  shape: RoundedRectangleBorder(
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
