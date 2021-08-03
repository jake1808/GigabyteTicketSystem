import 'package:formz/formz.dart';

enum EmailValidationError { invalid }
enum PasswordValidationError { invalid }
enum PhoneValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure([String value = '']) : super.pure(value);
  const Email.dirty([String value = '']) : super.dirty(value);

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegex.hasMatch(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([String value = '']) : super.pure(value);
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordValidationError? validator(String? value) {
    return _passwordRegex.hasMatch(value ?? '')
        ? null
        : PasswordValidationError.invalid;
  }
}

class TelePhone extends FormzInput<String, PhoneValidationError> {
  const TelePhone.pure([String value = '']) : super.pure(value);
  const TelePhone.dirty([String value = '']) : super.pure(value);

  static final _phoneRegex = RegExp(r'^(?:[+0]9)?[0-9]{10}$');

  @override
  PhoneValidationError? validator(String? value) {
    return _phoneRegex.hasMatch(value ?? '')
        ? null
        : PhoneValidationError.invalid;
  }
}
