part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent {
  final String id;
  LoadUser(this.id);
}

class SignOut extends UserEvent {
  @override
  List<Object> get props => [];
}
