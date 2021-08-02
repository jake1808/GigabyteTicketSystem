part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  final User user;
  final bool isLoading;

  const RegistrationState(this.user, this.isLoading);
}

class RegistrationInitial extends RegistrationState {
  RegistrationInitial() : super(User.empty(), false);
  @override
  List<Object> get props => [user];
}

class RegistrationModelChanged extends RegistrationState {
  final User user;
  RegistrationModelChanged(this.user) : super(user, false);

  @override
  List<Object> get props => [user];
}
