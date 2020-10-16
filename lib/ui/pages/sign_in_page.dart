part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    context.bloc<ThemeBloc>().add(ChangeTheme(
          ThemeData().copyWith(primaryColor: accentColor2),
        ));
    return WillPopScope(
        onWillPop: () {
          context.bloc<PageBloc>().add(GotoSplashPage());
          return;
        },
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
          child:
              BlocBuilder<LoginBloc, LoginState>(builder: (context, snapshot) {
            // ignore: close_sinks
            final bloc = BlocProvider.of<LoginBloc>(context);
            return BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is OnLoginLoading) {
                  bloc.changeLoading(true);
                } else if (state is OnLoginError) {
                  bloc.changeLoading(false);
                  Flushbar(
                    duration: Duration(seconds: 3),
                    flushbarPosition: FlushbarPosition.TOP,
                    message: state.message,
                    backgroundColor: accentColor6,
                  ).show(context);
                }
              },
              child: Scaffold(
                key: globalScaffoldKey,
                backgroundColor: Colors.white,
                body: Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 70,
                            child: Image.asset('assets/logo.png'),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 70, bottom: 40),
                            child: Text(
                              'Welcome Back,\nExplorer!',
                              style: blackTextFont.copyWith(fontSize: 20),
                            ),
                          ),
                          StreamBuilder<String>(
                              stream: bloc.emailStream,
                              builder: (context, snapshot) {
                                return TextField(
                                  decoration: InputDecoration(
                                      isDense: true,
                                      errorText: snapshot.error,
                                      labelText: 'Email Address',
                                      hintText: 'Ex. aaa@gmail.com',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                  onChanged: bloc.changeEmail,
                                );
                              }),
                          SizedBox(
                            height: 16,
                          ),
                          StreamBuilder<String>(
                              stream: bloc.passwordStream,
                              builder: (context, snapshot) {
                                return TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      errorText: snapshot.error,
                                      labelText: 'Password',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                  onChanged: bloc.changePassword,
                                );
                              }),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 30, bottom: 50),
                              width: 50,
                              height: 50,
                              child: StreamBuilder<bool>(
                                  stream: bloc.isLoadingStream,
                                  initialData: false,
                                  builder: (context, snapshot) {
                                    return snapshot.data
                                        ? SpinKitFadingCircle(
                                            color: mainColor,
                                          )
                                        : StreamBuilder<bool>(
                                            stream: bloc.submitValid,
                                            initialData: false,
                                            builder: (context, snapshot) {
                                              bool isValid =
                                                  snapshot.data ?? false;
                                              return FloatingActionButton(
                                                elevation: 0,
                                                backgroundColor: isValid
                                                    ? mainColor
                                                    : accentColor7,
                                                onPressed: isValid
                                                    ? () =>
                                                        bloc.add(LoginSubmit())
                                                    : null,
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.white,
                                                ),
                                              );
                                            });
                                  }),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'Start fresh now? ',
                                style: greyTextFont,
                                children: [
                                  TextSpan(
                                      text: 'Sign Up',
                                      style: purpleTextFont.copyWith(
                                          fontWeight: FontWeight.w400),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => context
                                            .bloc<PageBloc>()
                                            .add(GotoRegisterPage(
                                                Registration()))),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
