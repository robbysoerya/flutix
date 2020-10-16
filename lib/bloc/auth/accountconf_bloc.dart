import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';
import 'package:rxdart/subjects.dart';

part 'accountconf_event.dart';
part 'accountconf_state.dart';

class AccountconfirmationBloc
    extends Bloc<AccountconfirmationEvent, AccountconfirmationState> {
  AccountconfirmationBloc() : super(AccountconfirmationInitial());

  final isLoading = BehaviorSubject<bool>();

  Stream<bool> get isLoadingStream => isLoading.stream;
  Function(bool) get changeLoading => isLoading.sink.add;

  @override
  Stream<AccountconfirmationState> mapEventToState(
    AccountconfirmationEvent event,
  ) async* {
    if (event is AccountConfirmationSubmit) {
      yield OnAccountConfirmationLoading();
      Registration registration = event.registration;
      SignInSignUpResult result = await AuthServices.signUp(
          registration.email,
          registration.password,
          registration.name,
          registration.selectedGenres,
          registration.selectedLanguage);
      if (result.user == null) {
        yield OnAccountConfirmationError(result.message);
      }
    }
  }

  dispose() {
    isLoading.close();
  }
}
