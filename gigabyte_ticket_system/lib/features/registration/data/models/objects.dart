import 'package:formz/formz.dart';

/*THIS TO DO ALL FORM VALIDATION CHECKS IN ORDER TO ENSURE THAT THE USER
ENTERS THE RIGHT INFORMATION
 */

enum EmailValidationError { invalid }
enum PasswordValidationError { invalid }
enum PhoneValidationError { invalid }
enum NameValidationError { invaliid }

//THIS CLASS IS TO ENSURE THE USER INPUTS A VALID EMAIL
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

//THIS CLASS ENSURES THE USER INPUTS A PASSWORD WITH A LENGTH OF 8 AND ATLEAST 1 CHARACTER AND 1 NUMBER
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

//THIS CLASS ENSURES THAT A VALID PHONE NUMBER IS ENTERED
class TelePhone extends FormzInput<String, PhoneValidationError> {
  const TelePhone.pure([String value = '']) : super.pure(value);
  const TelePhone.dirty([String value = '']) : super.pure(value);

  static final _phoneRegex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  @override
  PhoneValidationError? validator(String? value) {
    return _phoneRegex.hasMatch(value ?? '')
        ? null
        : PhoneValidationError.invalid;
  }
}

//THIS CLASS ENSURE THAT THE USER INPUTS THEIR NAME
class Name extends FormzInput<String, NameValidationError> {
  const Name.pure([String value = '']) : super.pure(value);
  const Name.dirty([String value = '']) : super.dirty(value);
  static final _nameRegex = RegExp(r'^[a-zA-Z0-9]{4,10}$');
  @override
  NameValidationError? validator(String? value) {
    return _nameRegex.hasMatch(value ?? '')
        ? null
        : NameValidationError.invaliid;
  }
}
