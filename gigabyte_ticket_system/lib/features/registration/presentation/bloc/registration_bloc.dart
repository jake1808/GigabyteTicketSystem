import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gigabyte_ticket_system/features/registration/data/models/users.dart';
part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial());
  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
