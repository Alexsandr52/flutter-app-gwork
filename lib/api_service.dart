import 'dart:convert';
import 'package:gwork_flutter_application_1/models/analysis.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl;
  String? _token;

  ApiService(this.baseUrl);

  User get_user() {
    try {
      if (_token == null) {
        throw Exception('Token is null');
      }

      // Разделяем токен на части
      final parts = _token!.split('.');
      if (parts.length != 3) {
        throw Exception('Invalid token');
      }

      // Декодируем payload из Base64
      final payload = json.decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));

      // Извлечение данных из payload с учетом возможного отсутствия значений
      final name = payload['sub']['first_name'] as String;
      final email = payload['sub']['email'] as String;
      final surname = payload['sub']['last_name'] as String?;
      final birthdate = payload['sub']['birthdate'] as String?;
      final phone = payload['sub']['phone'] as String?;
      final selfInfo = payload['sub']['self_info'] as String?;

      // Обработка роли
      Roles role = Roles.patient;
      if (payload['sub']['role_id'] != null && payload['sub']['role_id'] == 1) {
        role = Roles.doctor;
      }

      // Обработка id
      final id = int.parse(payload['sub']['id'].toString());

      // Создание и возврат объекта User
      return User(
        name: name,
        email: email,
        role: role,
        id: id,
        surname: surname,
        birthdate: birthdate,
        phone: phone,
        selfInfo: selfInfo,
      );
    } catch (e) {
      print('Error decoding token: $e');
      rethrow;
    }
  }

  // Login
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'login': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _token = data['access_token'];
      _saveToken(_token!);
      final user = get_user();
      await _saveUser(user);
      return true;
    } else {
      return false;
    }
  }

  // Save user to SharedPreferences
  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode(user.toJson());
    await prefs.setString('user', userData);
  }
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Register
  Future<String> register(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message'] ?? data['error'];
    } else {
      return 'Error registering user';
    }
  }

  // Get Notifications
  Future<List<dynamic>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token is not available');
    }

    final url = Uri.parse('$baseUrl/notifications');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  // Send Image
  Future<Map<String, dynamic>> sendImage(int patientId, String imagePath) async {
    final url = Uri.parse('$baseUrl/sendimagebyid');
    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $_token'
      ..files.add(await http.MultipartFile.fromPath('image', imagePath))
      ..fields['patient_id'] = patientId.toString();

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await http.Response.fromStream(response);
      return jsonDecode(responseData.body);
    } else {
      throw Exception('Failed to send image');
    }
  }

  // Get Image Info by ID
  Future<List<dynamic>> getImageInfoById(int patientId) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final url = Uri.parse('$baseUrl/imagebyid');
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $token'},
  );
  print('Response Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Failed to load image info');
  }
}


  // Update Image Info
  Future<String> updateImageInfo(int imageId, String status) async {
    final url = Uri.parse('$baseUrl/update_image');
    final response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $_token', 'Content-Type': 'application/json'},
      body: jsonEncode({'image_id': imageId, 'processing_status': status}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message'];
    } else {
      throw Exception('Failed to update image info');
    }
  }

  // Get Patients by Doctor
  Future<List<int>> getPatientsByDoctor() async {
    final url = Uri.parse('$baseUrl/patients_by_doctor');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<int>.from(data['patients']);
    } else {
      throw Exception('Failed to load patients');
    }
  }
}
