import 'dart:convert';

class User {
  final String? name;
  final String? surName;
  final String? companyName;
  final String? telePhoneNumber;
  final String? email;
  final String? address;
  final String? city;
  final String? region;
  final String? userName;
  final String? password;

  const User({
    this.name,
    this.surName,
    this.companyName,
    this.telePhoneNumber,
    this.email,
    this.address,
    this.city,
    this.region,
    this.userName,
    this.password,
  });

  User copyWith({
    String? name,
    String? surName,
    String? companyName,
    String? telePhoneNumber,
    String? email,
    String? address,
    String? city,
    String? region,
    String? userName,
    String? password,
  }) {
    return User(
      name: name ?? this.name,
      surName: surName ?? this.surName,
      companyName: companyName ?? this.companyName,
      telePhoneNumber: telePhoneNumber ?? this.telePhoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      city: city ?? this.city,
      region: region ?? this.region,
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surName': surName,
      'companyName': companyName,
      'telePhoneNumber': telePhoneNumber,
      'email': email,
      'address': address,
      'city': city,
      'region': region,
      'userName': userName,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      surName: map['surName'],
      companyName: map['companyName'],
      telePhoneNumber: map['telePhoneNumber'],
      email: map['email'],
      address: map['address'],
      city: map['city'],
      region: map['region'],
      userName: map['userName'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, surName: $surName, companyName: $companyName, telePhoneNumber: $telePhoneNumber, email: $email, address: $address, city: $city, region: $region, userName: $userName, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.name == name &&
        other.surName == surName &&
        other.companyName == companyName &&
        other.telePhoneNumber == telePhoneNumber &&
        other.email == email &&
        other.address == address &&
        other.city == city &&
        other.region == region &&
        other.userName == userName &&
        other.password == password;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        surName.hashCode ^
        companyName.hashCode ^
        telePhoneNumber.hashCode ^
        email.hashCode ^
        address.hashCode ^
        city.hashCode ^
        region.hashCode ^
        userName.hashCode ^
        password.hashCode;
  }

  static empty() {}
}
