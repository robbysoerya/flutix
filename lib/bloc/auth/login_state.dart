part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  
}

class OnLoginInitial extends LoginState {
   @override
  List<Object> get props => [LoginInitial()];
}

class OnLoginLoading extends LoginState {
   @override
  List<Object> get props => [];
}

class OnLoginError extends LoginState {
  final String message;

  OnLoginError(this.message);

   @override
  List<Object> get props => [];
}
