part of 'registration_page_bloc.dart';

abstract class RegistrationPageEvent extends Equatable {
  const RegistrationPageEvent();

  @override
  List<Object> get props => [];
}

class GotoRegistrationPage extends RegistrationPageEvent {
  final Registration registration;
  GotoRegistrationPage(this.registration);
}

class GotoPreferencePage extends RegistrationPageEvent {
  final Registration registration;
  GotoPreferencePage(this.registration);
}

class GotoAccountConfPage extends RegistrationPageEvent {
  final Registration registration;
  GotoAccountConfPage(this.registration);
}