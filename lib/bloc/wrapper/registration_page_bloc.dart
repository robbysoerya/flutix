import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';

part 'registration_page_event.dart';
part 'registration_page_state.dart';

class RegistrationPageBloc
    extends Bloc<RegistrationPageEvent, RegistrationPageState> {
  RegistrationPageBloc() : super(RegistrationPageInitial());

  @override
  Stream<RegistrationPageState> mapEventToState(
    RegistrationPageEvent event,
  ) async* {
    if (event is GotoRegistrationPage) {
      yield OnRegistrationPage(event.registration);
    } else if (event is GotoPreferencePage) {
      yield OnPreferencePage(event.registration);
    } else if (event is GotoAccountConfPage) {
      yield OnAccountConfPage(event.registration);
    }
  }
}
