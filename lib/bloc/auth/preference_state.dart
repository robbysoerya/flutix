part of 'preference_bloc.dart';

abstract class PreferenceState {}

class PreferenceInitial extends PreferenceState {}

class OnPreferenceSubmit extends PreferenceState {
  final Registration registration;

  OnPreferenceSubmit(this.registration);
}

class OnPreferenceError extends PreferenceState {
  final String message;

  OnPreferenceError(this.message);
}
