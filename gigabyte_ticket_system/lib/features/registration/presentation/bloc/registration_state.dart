part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  final User user;
  const RegistrationState(this.user);
}

class RegistrationInitial extends RegistrationState {
  RegistrationInitial() : super(User.empty());
  @override
  List<Object> get props => [user];
}

class RegistrationModelChanged extends RegistrationState {
  final User user;
  RegistrationModelChanged(this.user) : super(user);

  @override
  List<Object> get props => [user];
}
