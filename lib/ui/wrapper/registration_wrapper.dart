part of 'wrapper.dart';

class RegistrationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          BlocProvider(
            create: (_) => RegistrationPageBloc(),
          ),
          BlocProvider(
            create: (_) => RegistrationBloc(),
          ),
          BlocProvider(
            create: (_) => PreferenceBloc(),
          ),
          BlocProvider(
            create: (_) => AccountconfirmationBloc(),
          ),
        ],
        child: BlocBuilder<RegistrationPageBloc, RegistrationPageState>(
            builder: (_, state) => (state is OnPreferencePage)
                ? PreferencePage(state.registration)
                : (state is OnAccountConfPage)
                    ? AccountConfirmationPage(state.registration)
                    : (state is OnRegistrationPage)
                        ? SignUpPage(state.registration)
                        : SignUpPage(Registration())));
  }
}
