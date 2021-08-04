part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  final Name name;
  final Email email;
  final Password password;
  final TelePhone phone;
  final User user;
  final FormzStatus status;

  RegistrationState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.user = const User(),
    this.phone = const TelePhone.pure(),
  });
  RegistrationState copywith({
    Name? name,
    Email? email,
    Password? password,
    FormzStatus? status,
    User? user,
    TelePhone? phone,
  }) {
    return RegistrationState(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        status: status ?? this.status,
        user: user ?? this.user);
  }

  @override
  List<Object> get props => [email, password, status, user, name, phone];
}
