part of 'registration_bloc.dart';

abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class OnRegistrationSubmit extends RegistrationState {
  final Registration registration;

  OnRegistrationSubmit(this.registration);
}

class OnRegistrationError extends RegistrationState {}
