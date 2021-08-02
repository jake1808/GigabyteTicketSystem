part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class NameChanged extends RegistrationEvent {
  final String name;
  NameChanged(this.name);
  @override
  List<Object> get props => [name];
}

class SurnameChanged extends RegistrationEvent {
  final String surName;
  SurnameChanged(this.surName);
  @override
  List<Object> get props => [surName];
}

class CompanyNameChanged extends RegistrationEvent {
  final String companyName;
  CompanyNameChanged(this.companyName);
  @override
  List<Object> get props => [companyName];
}

class TelePhoneNumberChanged extends RegistrationEvent {
  final String telePhoneNumber;
  TelePhoneNumberChanged(this.telePhoneNumber);
  @override
  List<Object> get props => [telePhoneNumber];
}

class EmailChanged extends RegistrationEvent {
  final String email;
  EmailChanged(this.email);
  @override
  List<Object> get props => [email];
}

class AddressChanged extends RegistrationEvent {
  final String address;
  AddressChanged(this.address);
  @override
  List<Object> get props => [address];
}

class CityChanged extends RegistrationEvent {
  final String city;
  CityChanged(this.city);
  @override
  List<Object> get props => [city];
}

class RegionChanged extends RegistrationEvent {
  final String region;
  RegionChanged(this.region);
  @override
  List<Object> get props => [region];
}

class UserNameChanged extends RegistrationEvent {
  final String userName;
  UserNameChanged(this.userName);
  @override
  List<Object> get props => [userName];
}

class PasswordChanged extends RegistrationEvent {
  final String password;
  PasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends RegistrationEvent {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}
