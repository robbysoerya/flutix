part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable{}

class LoginInitial extends LoginEvent{
  @override
  List<Object> get props =>[];

}
class LoginSubmit extends LoginEvent {
  @override
  List<Object> get props => [];
}
