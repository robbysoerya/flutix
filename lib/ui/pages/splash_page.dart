part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 136,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('assets/logo.png'))),
              ),
              Container(
                margin: EdgeInsets.only(top: 70, bottom: 16),
                child: Text('New Experience',
                    style: blackTextFont.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w500)),
              ),
              Text('Watch a new movie much\neasier than any before',
                  textAlign: TextAlign.center,
                  style: greyTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w300)),
              Padding(
                padding: const EdgeInsets.only(top: 70, bottom: 19),
                child: SizedBox(
                  width: 250,
                  height: 45,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: mainColor,
                    onPressed: () => context
                        .bloc<PageBloc>()
                        .add(GotoRegisterPage(Registration())),
                    child: Text(
                      'Get Started',
                      style: whiteTextFont.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Container(
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: greyTextFont.copyWith(fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                          text: 'Sign In',
                          style: purpleTextFont.copyWith(
                              fontWeight: FontWeight.w500),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                context.bloc<PageBloc>().add(GotoLoginPage())),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
