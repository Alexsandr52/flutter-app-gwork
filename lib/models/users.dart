enum Roles { patient, doctor }

class User {
  final String name;
  final String surname;
  final String email;
  final String? birthdate;
  final String? phone;
  final String? selfInfo;
  final Roles role;

  const User({
    required this.name,
    required this.surname,
    required this.email,
    required this.role,
    this.birthdate,
    this.phone,
    this.selfInfo,
  });
}
