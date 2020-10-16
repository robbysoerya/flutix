part of 'registration_page_bloc.dart';

abstract class RegistrationPageState extends Equatable {
  const RegistrationPageState();
  
  @override
  List<Object> get props => [];
}

class RegistrationPageInitial extends RegistrationPageState {}


class OnRegistrationPage extends RegistrationPageState {
  final Registration registration;

  OnRegistrationPage(this.registration);
}

class OnPreferencePage extends RegistrationPageState {
  final Registration registration;

  OnPreferencePage(this.registration);
}

class OnAccountConfPage extends RegistrationPageState {
  final Registration registration;
  OnAccountConfPage(this.registration);
}
