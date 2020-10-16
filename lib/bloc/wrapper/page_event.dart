part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();

  @override
  List<Object> get props => [];
}

class GotoSplashPage extends PageEvent {}

class GotoLoginPage extends PageEvent {}

class GotoMainPage extends PageEvent {}

class GotoRegisterPage extends PageEvent {
  final Registration registration;
  GotoRegisterPage(this.registration);
}
