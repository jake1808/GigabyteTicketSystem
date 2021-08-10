part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends RegistrationEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailUnfocused extends RegistrationEvent {}

class PasswordChanged extends RegistrationEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordUnfocused extends RegistrationEvent {}

class PhoneChanged extends RegistrationEvent {
  const PhoneChanged({required this.phone});

  final String phone;

  @override
  List<Object> get props => [phone];
}

class PhoneUnfocused extends RegistrationEvent {}

class NameChanged extends RegistrationEvent {
  const NameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class NameUnfocused extends RegistrationEvent {}

class SurNameChanged extends RegistrationEvent {
  const SurNameChanged({required this.surName});

  final String surName;

  @override
  List<Object> get props => [surName];
}

class SurNameUnfocused extends RegistrationEvent {}

class CompanyNameChanged extends RegistrationEvent {
  const CompanyNameChanged({required this.compayName});

  final String compayName;

  @override
  List<Object> get props => [compayName];
}

class CompanyNameUnfocused extends RegistrationEvent {}

class AddressChanged extends RegistrationEvent {
  const AddressChanged({required this.address});

  final String address;

  @override
  List<Object> get props => [address];
}

class AddressUnfocused extends RegistrationEvent {}

class CityChanged extends RegistrationEvent {
  const CityChanged({required this.city});

  final String city;

  @override
  List<Object> get props => [city];
}

class CityUnfocused extends RegistrationEvent {}

class RegionChanged extends RegistrationEvent {
  const RegionChanged({required this.region});

  final String region;

  @override
  List<Object> get props => [region];
}

class RegionUnfocused extends RegistrationEvent {}

class UserNameChanged extends RegistrationEvent {
  const UserNameChanged({required this.userName});

  final String userName;

  @override
  List<Object> get props => [userName];
}

class UserNameUnfocused extends RegistrationEvent {}

class FormSubmitted extends RegistrationEvent {}
