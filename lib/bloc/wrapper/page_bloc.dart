import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnInitialPage());

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GotoSplashPage) {
      yield OnSplashPage();
    } else if (event is GotoLoginPage) {
      yield OnLoginPage();
    } else if (event is GotoMainPage) {
      yield OnMainPage();
    } else if (event is GotoRegisterPage) {
      yield OnRegisterPage(event.registration);
    }
  }
}
