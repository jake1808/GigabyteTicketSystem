import 'package:formz/formz.dart';

/*THIS TO DO ALL FORM VALIDATION CHECKS IN ORDER TO ENSURE THAT THE USER
ENTERS THE RIGHT INFORMATION
 */

enum EmailValidationError { invalid }
enum PasswordValidationError { invalid }
enum PhoneValidationError { invalid }
enum NameValidationError { invalid }
enum SurNameValidationError { invalid }
enum CompanyNameValidationError { invalid }
enum AddressValidationError { invalid }
enum CityNameValidationError { invalid }
enum RegionNameValidationError { invalid }
enum UserNameValidationError { invalid }

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

  static final _phoneRegex = RegExp(r'^(?:[+0]9)?[0-9]{10}$');

  @override
  PhoneValidationError? validator(String? value) {
    print('here' + _phoneRegex.hasMatch(value ?? ' ').toString());
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
        : NameValidationError.invalid;
  }
}

class SurName extends FormzInput<String, SurNameValidationError> {
  const SurName.pure([String value = '']) : super.pure(value);
  const SurName.dirty([String value = '']) : super.dirty(value);
  static final _nameRegex = RegExp(r'^[a-zA-Z0-9]{4,10}$');
  @override
  SurNameValidationError? validator(String? value) {
    return _nameRegex.hasMatch(value ?? '')
        ? null
        : SurNameValidationError.invalid;
  }
}

class CompanyName extends FormzInput<String, CompanyNameValidationError> {
  const CompanyName.pure([String value = '']) : super.pure(value);
  const CompanyName.dirty([String value = '']) : super.dirty(value);
  static final _companyNameRegex = RegExp(r'^[a-zA-Z0-9]{4,10}$');
  @override
  CompanyNameValidationError? validator(String? value) {
    return _companyNameRegex.hasMatch(value ?? '')
        ? null
        : CompanyNameValidationError.invalid;
  }
}

class Address extends FormzInput<String, AddressValidationError> {
  const Address.pure([String value = '']) : super.pure(value);
  const Address.dirty([String value = '']) : super.dirty(value);
  static final _addressRegex = RegExp(r'\w+(\s\w+){2,}');
  @override
  AddressValidationError? validator(String? value) {
    return _addressRegex.hasMatch(value ?? '')
        ? null
        : AddressValidationError.invalid;
  }
}

class CityName extends FormzInput<String, CityNameValidationError> {
  const CityName.pure([String value = '']) : super.pure(value);
  const CityName.dirty([String value = '']) : super.dirty(value);
  static final _cityNameRegex = RegExp(r'^[a-zA-Z0-9]{4,10}$');
  @override
  CityNameValidationError? validator(String? value) {
    return _cityNameRegex.hasMatch(value ?? '')
        ? null
        : CityNameValidationError.invalid;
  }
}

class RegionName extends FormzInput<String, RegionNameValidationError> {
  const RegionName.pure([String value = '']) : super.pure(value);
  const RegionName.dirty([String value = '']) : super.dirty(value);
  static final _regionNameRegex = RegExp(r'^[a-zA-Z0-9]{4,10}$');
  @override
  RegionNameValidationError? validator(String? value) {
    return _regionNameRegex.hasMatch(value ?? '')
        ? null
        : RegionNameValidationError.invalid;
  }
}

class UserName extends FormzInput<String, UserNameValidationError> {
  const UserName.pure([String value = '']) : super.pure(value);
  const UserName.dirty([String value = '']) : super.dirty(value);
  static final _regionNameRegex = RegExp(r'^[a-zA-Z0-9]{4,10}$');
  @override
  UserNameValidationError? validator(String? value) {
    return _regionNameRegex.hasMatch(value ?? '')
        ? null
        : UserNameValidationError.invalid;
  }
}
