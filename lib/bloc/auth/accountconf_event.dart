part of 'accountconf_bloc.dart';

abstract class AccountconfirmationEvent {}

class AccountConfirmationSubmit extends AccountconfirmationEvent {
  final Registration registration;
  AccountConfirmationSubmit(this.registration);
}
