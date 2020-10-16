part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final Registration registration;

  AccountConfirmationPage(this.registration);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          context.bloc<RegistrationPageBloc>().add(GotoPreferencePage(widget.registration));
          return;
        },
        child: BlocListener<AccountconfirmationBloc, AccountconfirmationState>(
          listener: (context, state) {
            if (state is OnAccountConfirmationError) {
              Flushbar(
                duration: Duration(seconds: 3),
                flushbarPosition: FlushbarPosition.TOP,
                message: state.message,
                backgroundColor: accentColor6,
              ).show(context);
            } else if (state is OnAccountConfirmationLoading) {
              context.bloc<AccountconfirmationBloc>().changeLoading(true);
            }
          },
          child: Scaffold(
            body: Container(
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.all(defaultMargin),
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 22),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                onTap: () => context.bloc<RegistrationPageBloc>().add(
                                    GotoPreferencePage(widget.registration)),
                                child: Container(
                                  margin: EdgeInsets.only(top: 16),
                                  child: Icon(Icons.arrow_back),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Confirm\nNew Account',
                                style: blackTextFont.copyWith(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 90),
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    (widget.registration.profileImage == null)
                                        ? AssetImage('assets/user_pic.png')
                                        : FileImage(File(widget
                                            .registration.profileImage.path)))),
                      ),
                      SizedBox(height: 20),
                      Text('Welcome',
                          style: blackTextFont.copyWith(
                              fontWeight: FontWeight.w300, fontSize: 16)),
                      SizedBox(height: 8),
                      Text(widget.registration.name,
                          style: blackTextFont.copyWith(fontSize: 20)),
                      Padding(
                        padding: const EdgeInsets.only(top: 110, bottom: 70),
                        child: SizedBox(
                          width: 250,
                          height: 45,
                          child: StreamBuilder<bool>(
                              stream: context
                                  .bloc<AccountconfirmationBloc>()
                                  .isLoadingStream,
                              initialData: false,
                              builder: (context, snapshot) {
                                return snapshot.data
                                    ? SpinKitFadingCircle(
                                        color: mainColor,
                                      )
                                    : RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        color: Color(0xFF3E9D9D),
                                        onPressed: () {
                                          Registration registration =
                                              Registration(
                                                  name:
                                                      widget.registration.name,
                                                  email:
                                                      widget.registration.email,
                                                  password: widget
                                                      .registration.password,
                                                  selectedGenres: widget
                                                      .registration
                                                      .selectedGenres,
                                                  selectedLanguage: widget
                                                      .registration
                                                      .selectedLanguage);
                                          context
                                              .bloc<AccountconfirmationBloc>()
                                              .add(AccountConfirmationSubmit(
                                                  registration));
                                        },
                                        child: Text(
                                          'Create My Account',
                                          style: whiteTextFont.copyWith(
                                              fontSize: 16),
                                        ),
                                      );
                              }),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
