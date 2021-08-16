part of 'login_bloc.dart';

class LoginState extends Equatable {
  final User user;
  final Email email;
  final Password password;
  final FormzStatus status;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.user = const User(),
    this.status = FormzStatus.pure,
  });

  LoginState copywith({
    Email? email,
    Password? password,
    User? user,
    FormzStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        email,
        status,
        user,
        password,
      ];
}
