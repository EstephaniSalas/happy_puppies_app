class Dog {
  final int? id;
  final String name;
  final DateTime birthDate;
  final int age;
  final String gender;
  final double weight;
  final String size;
  final String breed;
  final String color;
  final String photo;

  Dog({
    this.id,
    required this.name,
    required this.birthDate,
    required this.age,
    required this.gender,
    required this.weight,
    required this.size,
    required this.breed,
    required this.color,
    required this.photo,
  });

  @override
  String toString() {
    return 'Dog(id: $id, name: $name, age: $age, gender: $gender, breed: $breed)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'birthDate': birthDate.toIso8601String(),
      'age': age,
      'gender': gender,
      'weight': weight,
      'size': size,
      'breed': breed,
      'color': color,
      'photo': photo,
    };
  }

  factory Dog.fromMap(Map<String, dynamic> map) {
    return Dog(
      id: map['id'],
      name: map['name'],
      birthDate: DateTime.parse(map['birthDate']),
      age: map['age'],
      gender: map['gender'],
      weight: map['weight'],
      size: map['size'],
      breed: map['breed'],
      color: map['color'],
      photo: map['photo'],
    );
  }
}
