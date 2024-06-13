enum Roles { patient, doctor }

class User {
  final String name;
  final String email;
  final String? surname;
  final String? birthdate;
  final String? phone;
  final String? selfInfo;
  final Roles role;
  final int id;

  const User({
    required this.name,
    required this.email,
    required this.role,
    required this.id,
    this.surname,
    this.birthdate,
    this.phone,
    this.selfInfo,
  });

  // Метод fromJson для создания объекта User из JSON-данных
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['first_name'] ?? '', // Если поле 'name' отсутствует, используем пустую строку
      email: json['email'] ?? '',
      role: Roles.values[json['role']?? 0],
      id: json['id'] ?? 0,
      surname: json['last_name'],
      birthdate: json['birthdate'],
      phone: json['phone_number'],
      selfInfo: json['other_personal_data'],
    );
  }

  // Метод toJson для преобразования объекта User в JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role.index,
      'id': id,
      'surname': surname,
      'birthdate': birthdate,
      'phone': phone,
      'selfInfo': selfInfo,
    };
  }
}
