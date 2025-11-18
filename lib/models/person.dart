class Person {
  int? id;
  String firstName;
  String lastName;
  String birthDate;
  String phone;
  String email;
  String address;

  Person({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.phone,
    required this.email,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate,
      'phone': phone,
      'email': email,
      'address': address,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory Person.fromMap(Map<String, dynamic> map) => Person(
    id: map['id'] as int?,
    firstName: map['firstName'] as String,
    lastName: map['lastName'] as String,
    birthDate: map['birthDate'] as String,
    phone: map['phone'] as String,
    email: map['email'] as String,
    address: map['address'] as String,
  );
}
