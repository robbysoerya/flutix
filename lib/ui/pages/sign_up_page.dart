part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final Registration registration;

  SignUpPage(this.registration);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialdata();
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));
    return WillPopScope(
        onWillPop: () {
          context.bloc<PageBloc>().add(GotoSplashPage());
          return;
        },
        child: BlocListener<RegistrationBloc, RegistrationState>(
            listener: (context, state) {
              print(state);
              if (state is OnRegistrationSubmit) {
                context
                    .bloc<RegistrationPageBloc>()
                    .add(GotoPreferencePage(state.registration));
              } else if (state is OnRegistrationError) {
                Flushbar(
                  duration: Duration(seconds: 3),
                  flushbarPosition: FlushbarPosition.TOP,
                  message: 'Please fill all field',
                  backgroundColor: accentColor6,
                ).show(context);
              }
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: ListView(
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
                                onTap: () => context
                                    .bloc<PageBloc>()
                                    .add(GotoSplashPage()),
                                child: Container(
                                  margin: EdgeInsets.only(top: 16),
                                  child: Icon(Icons.arrow_back),
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.topCenter,
                                child: Text('Create New\nYour Account',
                                    textAlign: TextAlign.center,
                                    style:
                                        blackTextFont.copyWith(fontSize: 20))),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 36),
                        width: 90,
                        height: 104,
                        child: Stack(
                          children: [
                            StreamBuilder<PickedFile>(
                                stream: context
                                    .bloc<RegistrationBloc>()
                                    .profileImageStream,
                                initialData: widget.registration.profileImage,
                                builder: (context, snapshot) {
                                  return Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: (snapshot.data == null)
                                                ? AssetImage(
                                                    'assets/user_pic.png')
                                                : FileImage(
                                                    File(snapshot.data.path)))),
                                  );
                                }),
                            StreamBuilder<PickedFile>(
                                stream: context
                                    .bloc<RegistrationBloc>()
                                    .profileImageStream,
                                initialData: widget.registration.profileImage,
                                builder: (context, snapshot) {
                                  return Align(
                                    alignment: Alignment.bottomCenter,
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (!snapshot.hasData) {
                                          context
                                              .bloc<RegistrationBloc>()
                                              .changeProfileImage(
                                                  await getImage());
                                        } else {
                                          context
                                              .bloc<RegistrationBloc>()
                                              .changeProfileImage(null);
                                        }
                                      },
                                      child: Container(
                                        height: 28,
                                        width: 28,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage((!snapshot
                                                        .hasData)
                                                    ? 'assets/btn_add_photo.png'
                                                    : 'assets/btn_del_photo.png'))),
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                      StreamBuilder<String>(
                          stream: context.bloc<RegistrationBloc>().nameStream,
                          initialData: widget.registration.name,
                          builder: (context, snapshot) {
                            return TextField(
                              controller: nameController,
                              onChanged:
                                  context.bloc<RegistrationBloc>().changeName,
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Full Name',
                                  hintText: 'Full Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                            );
                          }),
                      SizedBox(
                        height: 16,
                      ),
                      StreamBuilder<String>(
                          stream: context.bloc<RegistrationBloc>().emailStream,
                          initialData: widget.registration.email,
                          builder: (context, snapshot) {
                            return TextField(
                              controller: emailController,
                              onChanged:
                                  context.bloc<RegistrationBloc>().changeEmail,
                              decoration: InputDecoration(
                                  errorText: snapshot.error,
                                  isDense: true,
                                  labelText: 'Email Address',
                                  hintText: 'Ex. aaa@gmail.com',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                            );
                          }),
                      SizedBox(
                        height: 16,
                      ),
                      StreamBuilder<String>(
                          stream:
                              context.bloc<RegistrationBloc>().passwordStream,
                          initialData: widget.registration.password,
                          builder: (context, snapshot) {
                            return TextField(
                              controller: passwordController,
                              onChanged: context
                                  .bloc<RegistrationBloc>()
                                  .changePassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                  errorText: snapshot.error,
                                  isDense: true,
                                  labelText: 'Password',
                                  hintText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                            );
                          }),
                      SizedBox(
                        height: 16,
                      ),
                      StreamBuilder<String>(
                          stream: context
                              .bloc<RegistrationBloc>()
                              .confPasswordStream,
                          initialData: widget.registration.password,
                          builder: (context, snapshot) {
                            return TextField(
                              controller: retypePasswordController,
                              onChanged: context
                                  .bloc<RegistrationBloc>()
                                  .changeConfPassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                  errorText: snapshot.error,
                                  isDense: true,
                                  labelText: 'Confirm Password',
                                  hintText: 'Confirm Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                            );
                          }),
                      SizedBox(
                        height: 30,
                      ),
                      StreamBuilder<bool>(
                          stream: context.bloc<RegistrationBloc>().submitValid,
                          initialData: false,
                          builder: (context, snapshot) {
                            return FloatingActionButton(
                                onPressed: snapshot.hasData
                                    ? snapshot.data
                                        ? () => context
                                            .bloc<RegistrationBloc>()
                                            .add(RegistrationSubmit())
                                        : null
                                    : null,
                                child: Icon(Icons.arrow_forward),
                                backgroundColor: (snapshot.data ?? false)
                                    ? mainColor
                                    : accentColor7,
                                elevation: 0);
                          }),
                    ],
                  ),
                ],
              ),
            )));
  }

  initialdata() {
    nameController.text = widget.registration.name;
    emailController.text = widget.registration.email;
    passwordController.text = widget.registration.password;
    retypePasswordController.text = widget.registration.password;
  }
}
