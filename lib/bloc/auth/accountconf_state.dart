part of 'accountconf_bloc.dart';

abstract class AccountconfirmationState {
}

class AccountconfirmationInitial extends AccountconfirmationState {}

class OnAccountConfirmationError extends AccountconfirmationState {
  final String message;

  OnAccountConfirmationError(this.message);
}

class OnAccountConfirmationLoading extends AccountconfirmationState {}
