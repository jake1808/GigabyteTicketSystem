import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:gigabyte_ticket_system/features/registration/data/datasources/DataBase.dart';
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
    logger.w(state.email);
    logger.w(state.password);
    logger.w(state.address);
    logger.w(state.company);
    logger.w(state.name);
    logger.w(state.phone);
    logger.w(state.surName);
    logger.w(state.city);
    logger.w(state.region);
    logger.w(state.userName);
    logger.w(state.status);

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
        status: Formz.validate([
          email,
          state.password,
          state.phone,
          state.name,
          state.surName,
          state.company,
          state.address,
          state.city,
          state.region,
          state.userName,
        ]),
      );
    } else if (event is UserNameChanged) {
      final userName = UserName.dirty(event.userName);
      yield state.copywith(
        userName: userName,
        status: Formz.validate([
          state.email,
          state.password,
          state.phone,
          state.name,
          state.surName,
          state.company,
          state.address,
          state.city,
          state.region,
          userName,
        ]),
      );
    } else if (event is RegionChanged) {
      final region = RegionName.dirty(event.region);
      yield state.copywith(
        region: region,
        status: Formz.validate([
          state.email,
          state.password,
          state.phone,
          state.name,
          state.surName,
          state.company,
          state.address,
          state.city,
          region,
          state.userName,
        ]),
      );
    } else if (event is CityChanged) {
      final city = CityName.dirty(event.city);
      yield state.copywith(
        city: city.valid ? city : CityName.pure(event.city),
        status: Formz.validate([
          state.email,
          state.password,
          state.phone,
          state.name,
          state.surName,
          state.company,
          state.address,
          city,
          state.region,
          state.userName,
        ]),
      );
    } else if (event is NameChanged) {
      final name = Name.dirty(event.name);
      yield state.copywith(
        name: name.valid ? name : Name.pure(event.name),
        status: Formz.validate(
          [
            state.email,
            state.password,
            state.phone,
            name,
            state.surName,
            state.company,
            state.address,
            state.city,
            state.region,
            state.userName,
          ],
        ),
      );
    } else if (event is AddressChanged) {
      final address = Address.dirty(event.address);
      yield state.copywith(
        address: address.valid ? address : Address.pure(event.address),
        status: Formz.validate(
          [
            state.email,
            state.password,
            state.phone,
            state.name,
            state.surName,
            address,
            state.company,
            state.city,
            state.region,
            state.userName,
          ],
        ),
      );
    } else if (event is CompanyNameChanged) {
      final companyName = CompanyName.dirty(event.compayName);
      yield state.copywith(
        company: companyName.valid
            ? companyName
            : CompanyName.pure(event.compayName),
        status: Formz.validate(
          [
            state.email,
            state.password,
            state.phone,
            state.name,
            state.surName,
            companyName,
            state.address,
            state.city,
            state.region,
            state.userName,
          ],
        ),
      );
    } else if (event is SurNameChanged) {
      final surName = SurName.dirty(event.surName);
      yield state.copywith(
        surName: surName.valid ? surName : SurName.pure(event.surName),
        status: Formz.validate(
          [
            state.email,
            state.password,
            state.phone,
            state.name,
            surName,
            state.company,
            state.address,
            state.city,
            state.region,
            state.userName,
          ],
        ),
      );
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      yield state.copywith(
        password: password.valid ? password : Password.pure(event.password),
        status: Formz.validate([
          state.email,
          password,
          state.phone,
          state.name,
          state.surName,
          state.company,
          state.address,
          state.city,
          state.region,
          state.userName,
        ]),
      );
    } else if (event is PhoneChanged) {
      final phone = TelePhone.dirty(event.phone);
      yield state.copywith(
        phone: phone.valid ? phone : TelePhone.pure(event.phone),
        status: Formz.validate([
          state.email,
          state.password,
          phone,
          state.name,
          state.surName,
          state.company,
          state.address,
          state.city,
          state.region,
          state.userName,
        ]),
      );
    } else if (event is NameUnfocused) {
      final name = Name.dirty(state.name.value);
      yield state.copywith(
        name: name,
        status: Formz.validate(
          [
            state.email,
            state.password,
            state.phone,
            name,
            state.surName,
            state.company,
            state.address,
            state.city,
            state.userName,
          ],
        ),
      );
    } else if (event is RegionUnfocused) {
      final region = RegionName.dirty(state.region.value);
      yield state.copywith(
          region: region,
          status: Formz.validate([
            state.email,
            state.password,
            state.phone,
            state.name,
            state.surName,
            state.company,
            state.address,
            state.city,
            region,
            state.userName,
          ]));
    } else if (event is CityUnfocused) {
      final city = CityName.dirty(state.city.value);
      yield state.copywith(
        city: city,
        status: Formz.validate([
          state.email,
          state.password,
          state.phone,
          state.name,
          state.surName,
          state.company,
          state.address,
          city,
          state.region,
          state.userName,
        ]),
      );
    } else if (event is AddressUnfocused) {
      final address = Address.dirty(state.address.value);
      yield state.copywith(
        address: address,
        status: Formz.validate(
          [
            state.region,
            state.email,
            state.password,
            state.phone,
            state.name,
            state.surName,
            address,
            state.company,
            state.city,
            state.userName,
          ],
        ),
      );
    } else if (event is CompanyNameUnfocused) {
      final companyName = CompanyName.dirty(state.company.value);
      yield state.copywith(
        company: companyName,
        status: Formz.validate(
          [
            state.email,
            state.password,
            state.phone,
            state.name,
            state.surName,
            companyName,
            state.address,
            state.city,
            state.region,
            state.userName,
          ],
        ),
      );
    } else if (event is SurNameUnfocused) {
      final surName = SurName.dirty(state.surName.value);
      yield state.copywith(
        surName: surName,
        status: Formz.validate(
          [
            state.email,
            state.password,
            state.phone,
            state.name,
            surName,
            state.company,
            state.address,
            state.city,
            state.region,
            state.userName,
          ],
        ),
      );
    } else if (event is EmailUnfocused) {
      final email = Email.dirty(state.email.value);
      yield state.copywith(
        email: email,
        status: Formz.validate(
          [
            email,
            state.password,
            state.phone,
            state.name,
            state.surName,
            state.company,
            state.address,
            state.city,
            state.region,
            state.userName,
          ],
        ),
      );
    } else if (event is UserNameUnfocused) {
      final userName = UserName.dirty(state.email.value);
      yield state.copywith(
        userName: userName,
        status: Formz.validate(
          [
            state.email,
            state.password,
            state.phone,
            state.name,
            state.surName,
            state.company,
            state.address,
            state.city,
            state.region,
            userName,
          ],
        ),
      );
    } else if (event is PasswordUnfocused) {
      final password = Password.dirty(state.password.value);
      yield state.copywith(
        password: password,
        status: Formz.validate(
          [
            state.email,
            password,
            state.phone,
            state.name,
            state.surName,
            state.company,
            state.address,
            state.city,
            state.region,
            state.userName,
          ],
        ),
      );
    } else if (event is PhoneUnfocused) {
      final phone = TelePhone.dirty(state.phone.value);
      yield state.copywith(
        phone: phone,
        status: Formz.validate([
          state.email,
          state.password,
          phone,
          state.name,
          state.surName,
          state.company,
          state.address,
          state.city,
          state.region,
          state.userName,
        ]),
      );
    } else if (event is FormSubmitted) {
      if (state.status.isValidated) {
        yield state.copywith(
            status: FormzStatus.submissionInProgress,
            user: User(
              name: state.name.value,
              surname: state.surName.value,
              telephone: state.phone.value,
              email: state.email.value,
              password: state.password.value,
              companyname: state.company.value,
              address: state.address.value,
              city: state.city.value,
              region: state.region.value,
              username: state.userName.value,
            ));
        try {
          DBhelper.db.initDB();
          User? result = await DBhelper.db.getUser(state.user);
          logger.w(result);
          if (result == null) {
            int res = await DBhelper.db.newUser(state.user);
            state.user.copyWith(id: res);
            logger.w(state.user);
          } else {
            //TODO ALREADY IN USE
            print('already made');
          }
          logger.w(result.toString() + 'here');
        } catch (e) {
          logger.w(e);
        }

        logger.w(state.user);
        yield state.copywith(status: FormzStatus.submissionSuccess);
      }
    }
  }
}
