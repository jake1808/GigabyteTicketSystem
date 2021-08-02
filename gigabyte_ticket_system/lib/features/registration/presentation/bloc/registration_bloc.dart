import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigabyte_ticket_system/features/registration/data/models/users.dart';
import 'package:gigabyte_ticket_system/features/registration/data/repositories/repository.dart';
part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial());
  @override
  RegistrationState get initialState => RegistrationInitial();
  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is UserNameChanged) {
      bool isValidModel = await isValid(
          event.userName,
          state.user.password,
          state.user.confirmPassword,
          state.user.email,
          state.user.name,
          state.user.surName,
          state.user.telePhoneNumber,
          state.user.address,
          state.user.city,
          state.user.companyName,
          state.user.region);
      yield RegistrationModelChanged(state.user
          .copyWith(userName: event.userName, isValidUser: isValidModel));
    }
    if (event is NameChanged) {
      bool isValidModel = await isValid(
          state.user.userName,
          state.user.password,
          state.user.confirmPassword,
          state.user.email,
          event.name,
          state.user.surName,
          state.user.telePhoneNumber,
          state.user.address,
          state.user.city,
          state.user.companyName,
          state.user.region);
      yield RegistrationModelChanged(
          state.user.copyWith(name: event.name, isValidUser: isValidModel));
    }
    if (event is SurnameChanged) {
      bool isValidModel = await isValid(
          state.user.userName,
          state.user.password,
          state.user.confirmPassword,
          state.user.email,
          state.user.name,
          event.surName,
          state.user.telePhoneNumber,
          state.user.address,
          state.user.city,
          state.user.companyName,
          state.user.region);
      yield RegistrationModelChanged(state.user
          .copyWith(surName: event.surName, isValidUser: isValidModel));
    }
    if (event is CompanyNameChanged) {
      bool isValidModel = await isValid(
          state.user.userName,
          state.user.password,
          state.user.confirmPassword,
          state.user.email,
          state.user.name,
          state.user.surName,
          state.user.telePhoneNumber,
          state.user.address,
          state.user.city,
          event.companyName,
          state.user.region);
      yield RegistrationModelChanged(state.user
          .copyWith(companyName: event.companyName, isValidUser: isValidModel));
    }
    if (event is TelePhoneNumberChanged) {
      bool isValidModel = await isValid(
          state.user.userName,
          state.user.password,
          state.user.confirmPassword,
          state.user.email,
          state.user.name,
          state.user.surName,
          event.telePhoneNumber,
          state.user.address,
          state.user.city,
          state.user.companyName,
          state.user.region);
      yield RegistrationModelChanged(state.user.copyWith(
          telePhoneNumber: event.telePhoneNumber, isValidUser: isValidModel));
    }
    if (event is EmailChanged) {
      bool isValidModel = await isValid(
          state.user.userName,
          state.user.password,
          state.user.confirmPassword,
          event.email,
          state.user.name,
          state.user.surName,
          state.user.telePhoneNumber,
          state.user.address,
          state.user.city,
          state.user.companyName,
          state.user.region);
      yield RegistrationModelChanged(
          state.user.copyWith(email: event.email, isValidUser: isValidModel));
    }
    if (event is AddressChanged) {
      bool isValidModel = await isValid(
          state.user.userName,
          state.user.password,
          state.user.confirmPassword,
          state.user.email,
          state.user.name,
          state.user.surName,
          state.user.telePhoneNumber,
          event.address,
          state.user.city,
          state.user.companyName,
          state.user.region);
      yield RegistrationModelChanged(state.user
          .copyWith(address: event.address, isValidUser: isValidModel));
    }
    if (event is CityChanged) {
      bool isValidModel = await isValid(
          state.user.userName,
          state.user.password,
          state.user.confirmPassword,
          state.user.email,
          state.user.name,
          state.user.surName,
          state.user.telePhoneNumber,
          state.user.address,
          event.city,
          state.user.companyName,
          state.user.region);
      yield RegistrationModelChanged(
          state.user.copyWith(city: event.city, isValidUser: isValidModel));
    }
    if (event is RegionChanged) {
      bool isValidModel = await isValid(
        state.user.userName,
        state.user.password,
        state.user.confirmPassword,
        state.user.email,
        state.user.name,
        state.user.surName,
        state.user.telePhoneNumber,
        state.user.address,
        state.user.city,
        state.user.companyName,
        event.region,
      );
      yield RegistrationModelChanged(
          state.user.copyWith(region: event.region, isValidUser: isValidModel));
    }
    if (event is PasswordChanged) {
      bool isValidModel = await isValid(
        state.user.userName,
        event.password,
        state.user.confirmPassword,
        state.user.email,
        state.user.name,
        state.user.surName,
        state.user.telePhoneNumber,
        state.user.address,
        state.user.city,
        state.user.companyName,
        state.user.region,
      );
      yield RegistrationModelChanged(state.user
          .copyWith(password: event.password, isValidUser: isValidModel));
    }
    if (event is ConfirmPasswordChanged) {
      bool isValidModel = await isValid(
        state.user.userName,
        state.user.password,
        event.confirmPassword,
        state.user.email,
        state.user.name,
        state.user.surName,
        state.user.telePhoneNumber,
        state.user.address,
        state.user.city,
        state.user.companyName,
        state.user.region,
      );
      yield RegistrationModelChanged(
          state.user.copyWith(isValidUser: isValidModel));
    }
  }
}

Future<bool> isValid(
  String? userName,
  String? password,
  String? confirmPassword,
  String? email,
  String? name,
  String? surName,
  String? phoneNumber,
  String? address,
  String? city,
  String? companyName,
  String? region,
) async {
  bool isValidUser = await RegistrationRepository.isUserAvialable(userName!);

  RegExp exp = new RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");
  RegExp emailExp = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  RegExp phoneExp = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  bool isUserNameValid = userName!.length >= 8;
  bool isValidPassword = exp.hasMatch(password!);
  bool isConfirmPasswordMatch = password == confirmPassword;
  bool isEmailValid = emailExp.hasMatch(email!);
  bool isNameValid = name!.length > 0;
  bool isSurNameValid = surName!.length > 0;
  bool isPhoneNumberValid = phoneExp.hasMatch(phoneNumber!);
  bool isAddressValid = address!.length > 0;
  bool isCityValid = city!.length > 0;
  bool isCompanyNameValid = companyName!.length > 0;
  bool isRegionValid = region!.length > 0;

  return isValidUser &&
      isUserNameValid &&
      isAddressValid &&
      isCityValid &&
      isPhoneNumberValid &&
      isNameValid &&
      isSurNameValid &&
      isConfirmPasswordMatch &&
      isEmailValid &&
      isValidPassword &&
      isCompanyNameValid &&
      isRegionValid;
}
