import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/api_service.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';
// Добавляем импорт ApiService

class DoctorPatientList extends StatefulWidget {
  const DoctorPatientList({Key? key}) : super(key: key);

  @override
  _DoctorPatientListState createState() => _DoctorPatientListState();
}

class _DoctorPatientListState extends State<DoctorPatientList> {
  List<User> patients = [];
  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService('https://alexsandr52-database-management-graduate-work-4add.twc1.net'); // Инициализация ApiService с вашим базовым URL
    _fetchPatients();
  }

  // Метод для загрузки списка пациентов
  Future<void> _fetchPatients() async {
    try {
      // Получаем список ID пациентов
      List<int> patientIds = await apiService.getPatientsByDoctor();
      // Загрузка информации о пациентах по их ID
      List<User> fetchedPatients = [];
      for (int id in patientIds) {
        // Получение информации о каждом пациенте по ID
        User patient = await apiService.getPatientById(id);
        fetchedPatients.add(patient);
      }

      setState(() {
        patients = fetchedPatients;
      });
    } catch (e) {
      print('Error fetching patients: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themedata.constBackgroundColor,
      appBar: CustomAppBar(title: 'Пациенты'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return PatientCard(patient: patients[index]);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
          itemCount: patients.length,
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBarDoctor(pageIndex: 1),
    );
  }
}
