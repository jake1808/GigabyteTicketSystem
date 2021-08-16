part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class Emailchanged extends LoginEvent {
  const Emailchanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class Emailunfocused extends LoginEvent {}

class Passwordchanged extends LoginEvent {
  const Passwordchanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class Passwordunfocused extends LoginEvent {}

class Formsubmitted extends LoginEvent {}
