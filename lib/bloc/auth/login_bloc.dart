import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/services/services.dart';
import 'package:flutix/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(OnLoginInitial());

  final emailController = BehaviorSubject<String>();
  final passwordController = BehaviorSubject<String>();
  final isLoading = BehaviorSubject<bool>();

  Stream<bool> get isLoadingStream => isLoading.stream;
  Function(bool) get changeLoading => isLoading.sink.add;

  Stream<String> get emailStream =>
      emailController.stream.transform(LoginValidator().validateEmail);
  Stream<String> get passwordStream =>
      passwordController.stream.transform(LoginValidator().validatePassword);
  Stream<bool> get submitValid =>
      CombineLatestStream.combine2(emailStream, passwordStream, (a, b) => true);

  Function(String) get changeEmail => emailController.sink.add;
  Function(String) get changePassword => passwordController.sink.add;

  String get email => emailController.value;
  String get password => passwordController.value;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginSubmit) {
      yield OnLoginLoading();
      SignInSignUpResult result = await AuthServices.signIn(email, password);
      if (result.user == null) {
        yield OnLoginError(result.message);
      }
    }
  }

  dispose() {
    emailController.close();
    passwordController.close();
    isLoading.close();
  }
}
