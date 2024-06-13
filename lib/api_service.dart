import 'dart:convert';
import 'dart:io';
import 'package:gwork_flutter_application_1/models/news.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl;
  String? _token;

  ApiService(this.baseUrl);

  /// Получение пользователя из токена
  User getUser() {
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
      final payload = json.decode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );

      // Извлечение данных из payload
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

  /// Авторизация
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
      await _saveToken(_token!);
      final user = getUser();
      await _saveUser(user);
      return true;
    } else {
      return false;
    }
  }

  /// Сохранение пользователя в SharedPreferences
  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode(user.toJson());
    await prefs.setString('user', userData);
  }

  /// Сохранение токена в SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  /// Регистрация
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

  /// Получение уведомлений
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

  /// Отправка изображения
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

  /// Получение информации об изображении по ID
  Future<List<dynamic>> getImageInfoById(int patientId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token is not available');
    }

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

  // Получение изображений пациента
  Future<List<dynamic>> postImageInfoByIdDoctor(int patientId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token is not available');
    }

    final url = Uri.parse('$baseUrl/imagebyid');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'patient_id': patientId}),
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

  /// Обновление информации об изображении
  Future<String> updateImageInfo(int imageId, String status) async {
    final url = Uri.parse('$baseUrl/update_image');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({'image_id': imageId, 'processing_status': status}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message'];
    } else {
      throw Exception('Failed to update image info');
    }
  }

  /// Получение списка пациентов по ID доктора
  Future<List<int>> getPatientsByDoctor() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token is not available');
    }

    final url = Uri.parse('$baseUrl/patients_by_doctor');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<int>.from(data['patients']);
    } else {
      throw Exception('Failed to load patients');
    }
  }

  Future<User> getPatientById(int patientId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.post(
        Uri.parse('$baseUrl/patient_info'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Включаем JWT токен в заголовок запроса
        },
        body: jsonEncode(<String, dynamic>{'patient_id': patientId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return User.fromJson(data);
      } else {
        throw Exception('Failed to get patient info');
      }
    } catch (e) {
      throw Exception('Error getting patient info: $e');
    }
  }

// Метод для получения новостей
  Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse('$baseUrl/news'));

    if (response.statusCode == 200) {
      List<dynamic> newsList = json.decode(response.body);
      return newsList.map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<void> uploadImage(int patientId, File imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token is not available');
    }

    final url = Uri.parse('$baseUrl/sendimagebyid');
    final request = http.MultipartRequest('POST', url);

    // Добавляем заголовки и поля формы
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['patient_id'] = patientId.toString();
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    final response = await request.send();

    if (response.statusCode != 200) {
      final responseBody = await response.stream.bytesToString();
      throw Exception('Failed to upload image: $responseBody');
    }
  }

  Future<Map<String, dynamic>> updateUserInfo(
    int userId, {
    String? newFirstName,
    String? newLastName,
    String? newEmail,
    String? newPhoneNumber,
    String? newPersonalData,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      
      if (token == null) {
        return {'error': 'Токен не найден. Пожалуйста, выполните вход.'};
      }

      final url = Uri.parse('$baseUrl/user_settings');
      final Map<String, dynamic> requestBody = {
        'user_id': userId,
        if (newFirstName != null) 'new_first_name': newFirstName,
        if (newLastName != null) 'new_last_name': newLastName,
        if (newEmail != null) 'new_email': newEmail,
        if (newPhoneNumber != null) 'new_phone_number': newPhoneNumber,
        if (newPersonalData != null) 'new_personal_data': newPersonalData,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      print(response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        return {'error': 'Некорректные данные. Проверьте введенные данные.'};
      } else if (response.statusCode == 401) {
        return {'error': 'Неавторизованный доступ. Пожалуйста, выполните вход.'};
      } else if (response.statusCode == 403) {
        return {'error': 'Доступ запрещен.'};
      } else if (response.statusCode == 404) {
        return {'error': 'Пользователь не найден.'};
      } else {
        return {'error': 'Ошибка обновления данных. Попробуйте снова.'};
      }
    } catch (e) {
      return {'error': 'Произошла ошибка: $e'};
    }
  }
}
