part of 'wrapper.dart';

class MainWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    auth.User firebaseUser = Provider.of<auth.User>(context);
    if (firebaseUser == null) {
      if (!(prevPageEvent is GotoSplashPage)) {
        prevPageEvent = GotoSplashPage();

        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GotoMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        // context.bloc<AccountconfirmationBloc>().changeLoading(false);
        prevPageEvent = GotoMainPage();

        context.bloc<PageBloc>().add(prevPageEvent);
      }
    }

    return BlocBuilder<PageBloc, PageState>(
      builder: (_, pagestate) => (pagestate is OnSplashPage)
          ? SplashPage()
          : (pagestate is OnLoginPage)
              ? SignInPage()
              : (pagestate is OnRegisterPage)
                  ? RegistrationWrapper()
                  : MainPage(),
    );
  }
}
