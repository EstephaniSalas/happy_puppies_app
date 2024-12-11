class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String postalCode;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.postalCode,
  });

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, phone: $phone, postalCode: $postalCode)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'postalCode': postalCode,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      phone: map['phone'],
      postalCode: map['postalCode'],
    );
  }
}
