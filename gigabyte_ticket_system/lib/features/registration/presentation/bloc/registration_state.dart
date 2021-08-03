part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  final Email email;
  final Password password;
  final TelePhone phone;
  final User user;
  final FormzStatus status;

  RegistrationState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.user = const User(),
    this.phone = const TelePhone.pure(),
  });
  RegistrationState copywith({
    Email? email,
    Password? password,
    FormzStatus? status,
    User? user,
    TelePhone? phone,
  }) {
    return RegistrationState(
        email: email ?? this.email,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        status: status ?? this.status,
        user: user ?? this.user);
  }

  @override
  List<Object> get props => [email, password, status, user];
}
