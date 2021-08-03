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

class FormSubmitted extends RegistrationEvent {}
