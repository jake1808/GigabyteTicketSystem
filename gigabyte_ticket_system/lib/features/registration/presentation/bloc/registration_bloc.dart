import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:gigabyte_ticket_system/features/registration/data/models/models.dart';
import 'package:logger/logger.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationState());
  var logger = Logger(printer: PrettyPrinter());
  @override
  void onTransition(
      Transition<RegistrationEvent, RegistrationState> transition) {
    logger.w(transition);
    logger.w(state.phone);
    super.onTransition(transition);
  }

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copywith(
        email: email.valid ? email : Email.pure(event.email),
        status:
            Formz.validate([email, state.password, state.phone, state.name]),
      );
    } else if (event is NameChanged) {
      final name = Name.dirty(event.name);
      yield state.copywith(
        name: name.valid ? name : Name.pure(event.name),
        status: Formz.validate(
          [state.email, state.password, state.password, state.phone, name],
        ),
      );
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      yield state.copywith(
        password: password.valid ? password : Password.pure(event.password),
        status:
            Formz.validate([state.email, password, state.phone, state.name]),
      );
    } else if (event is PhoneChanged) {
      final phone = TelePhone.dirty(event.phone);
      yield state.copywith(
        phone: phone.valid ? phone : TelePhone.pure(event.phone),
        status:
            Formz.validate([state.email, state.password, phone, state.name]),
      );
    } else if (event is NameUnfocused) {
      final name = Name.dirty(state.name.value);
      yield state.copywith(
        name: name,
        status: Formz.validate(
          [state.email, state.password, state.phone, name],
        ),
      );
    } else if (event is EmailUnfocused) {
      final email = Email.dirty(state.email.value);
      yield state.copywith(
        email: email,
        status: Formz.validate(
          [email, state.password, state.phone, state.name],
        ),
      );
    } else if (event is PasswordUnfocused) {
      final password = Password.dirty(state.password.value);
      yield state.copywith(
        password: password,
        status: Formz.validate(
          [state.email, password, state.phone, state.name],
        ),
      );
    } else if (event is PhoneUnfocused) {
      final phone = TelePhone.dirty(state.phone.value);
      yield state.copywith(
        phone: phone,
        status:
            Formz.validate([state.email, state.password, phone, state.name]),
      );
    } else if (event is FormSubmitted) {
      if (state.status.isValidated) {
        yield state.copywith(
            status: FormzStatus.submissionInProgress,
            user: User(
              name: state.name.value,
              email: state.email.value,
              password: state.password.value,
              telePhoneNumber: state.phone.value,
            ));

        logger.w(state.user);
        yield state.copywith(status: FormzStatus.submissionSuccess);
      }
    }
  }
}
