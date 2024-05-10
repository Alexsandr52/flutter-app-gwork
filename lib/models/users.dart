enum Roles { patient, doctor }

class User {
  final String name;
  final String surname;
  final String email;
  final String? birthdate;
  final String? phone;
  final String? selfInfo;
  final Roles role;
  final int id;

  const User({
    required this.name,
    required this.surname,
    required this.email,
    required this.role,
    required this.id,
    this.birthdate,
    this.phone,
    this.selfInfo,
  });

  // сетеры для бд
}
