import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:gigabyte_ticket_system/data/datasources/DataBase.dart';
import 'package:gigabyte_ticket_system/data/models/objects.dart';
import 'package:gigabyte_ticket_system/data/models/users.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());
  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copywith(
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate(
          [
            email,
            state.password,
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
          ],
        ),
      );
    } else if (event is FormSubmitted) {
      if (state.status.isValidated) {
        yield state.copywith(
            status: FormzStatus.submissionInProgress,
            user: User(
              email: state.email.value,
              password: state.password.value,
            ));
        try {
          DBhelper.db.initDB();
          User? result = await DBhelper.db.getUser(state.user);
          if (result != null) {
            yield state.copywith(
              user: result,
              status: FormzStatus.submissionSuccess,
            );
          } else {
            yield state.copywith(
              status: FormzStatus.submissionFailure,
            );
          }
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
