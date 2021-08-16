import 'dart:convert';

class Task {
  int? id;
  String? urgencyLevel;
  String? email;
  String? telePhone;
  String? request;
  String? ticketProblemDescription;
  String? company;
  String? branchCityName;
  String? region;
  String? companyAddress;
  String? file;
  String? name;
  String? surname;
  Task({
    this.id,
    this.urgencyLevel,
    this.email,
    this.telePhone,
    this.request,
    this.ticketProblemDescription,
    this.company,
    this.branchCityName,
    this.region,
    this.companyAddress,
    this.file,
    this.name,
    this.surname,
  });

  Task copyWith({
    int? id,
    String? urgencyLevel,
    String? email,
    String? telePhone,
    String? request,
    String? ticketProblemDescription,
    String? company,
    String? branchCityName,
    String? region,
    String? companyAddress,
    String? file,
    String? name,
    String? surname,
  }) {
    return Task(
      id: id ?? this.id,
      urgencyLevel: urgencyLevel ?? this.urgencyLevel,
      email: email ?? this.email,
      telePhone: telePhone ?? this.telePhone,
      request: request ?? this.request,
      ticketProblemDescription:
          ticketProblemDescription ?? this.ticketProblemDescription,
      company: company ?? this.company,
      branchCityName: branchCityName ?? this.branchCityName,
      region: region ?? this.region,
      companyAddress: companyAddress ?? this.companyAddress,
      file: file ?? this.file,
      name: name ?? this.name,
      surname: surname ?? this.surname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'urgencyLevel': urgencyLevel,
      'email': email,
      'telePhone': telePhone,
      'request': request,
      'ticketProblemDescription': ticketProblemDescription,
      'company': company,
      'branchCityName': branchCityName,
      'region': region,
      'companyAddress': companyAddress,
      'file': file,
      'name': name,
      'surname': surname,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      urgencyLevel: map['urgencyLevel'],
      email: map['email'],
      telePhone: map['telePhone'],
      request: map['request'],
      ticketProblemDescription: map['ticketProblemDescription'],
      company: map['company'],
      branchCityName: map['branchCityName'],
      region: map['region'],
      companyAddress: map['companyAddress'],
      file: map['file'],
      name: map['name'],
      surname: map['surname'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task(id: $id, urgencyLevel: $urgencyLevel, email: $email, telePhone: $telePhone, request: $request, ticketProblemDescription: $ticketProblemDescription, company: $company, branchCityName: $branchCityName, region: $region, companyAddress: $companyAddress, file: $file, name: $name, surname: $surname)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task &&
        other.id == id &&
        other.urgencyLevel == urgencyLevel &&
        other.email == email &&
        other.telePhone == telePhone &&
        other.request == request &&
        other.ticketProblemDescription == ticketProblemDescription &&
        other.company == company &&
        other.branchCityName == branchCityName &&
        other.region == region &&
        other.companyAddress == companyAddress &&
        other.file == file &&
        other.name == name &&
        other.surname == surname;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        urgencyLevel.hashCode ^
        email.hashCode ^
        telePhone.hashCode ^
        request.hashCode ^
        ticketProblemDescription.hashCode ^
        company.hashCode ^
        branchCityName.hashCode ^
        region.hashCode ^
        companyAddress.hashCode ^
        file.hashCode ^
        name.hashCode ^
        surname.hashCode;
  }
}
