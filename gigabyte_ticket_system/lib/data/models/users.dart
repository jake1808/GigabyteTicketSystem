import 'dart:convert';

class User {
  final int? id;
  final String? name;
  final String? surname;
  final String? companyname;
  final String? telephone;
  final String? email;
  final String? address;
  final String? city;
  final String? region;
  final String? username;
  final String? password;
  const User({
    this.id,
    this.name,
    this.surname,
    this.companyname,
    this.telephone,
    this.email,
    this.address,
    this.city,
    this.region,
    this.username,
    this.password,
  });

  User copyWith({
    int? id,
    String? name,
    String? surname,
    String? companyname,
    String? telePhonenumber,
    String? email,
    String? address,
    String? city,
    String? region,
    String? username,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      companyname: companyname ?? this.companyname,
      telephone: telePhonenumber ?? this.telephone,
      email: email ?? this.email,
      address: address ?? this.address,
      city: city ?? this.city,
      region: region ?? this.region,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'companyname': companyname,
      'telePhonenumber': telephone,
      'email': email,
      'address': address,
      'city': city,
      'region': region,
      'username': username,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      companyname: map['companyname'],
      telephone: map['telePhonenumber'],
      email: map['email'],
      address: map['address'],
      city: map['city'],
      region: map['region'],
      username: map['username'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, surname: $surname, companyname: $companyname, telePhonenumber: $telephone, email: $email, address: $address, city: $city, region: $region, username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.surname == surname &&
        other.companyname == companyname &&
        other.telephone == telephone &&
        other.email == email &&
        other.address == address &&
        other.city == city &&
        other.region == region &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        surname.hashCode ^
        companyname.hashCode ^
        telephone.hashCode ^
        email.hashCode ^
        address.hashCode ^
        city.hashCode ^
        region.hashCode ^
        username.hashCode ^
        password.hashCode;
  }
}
