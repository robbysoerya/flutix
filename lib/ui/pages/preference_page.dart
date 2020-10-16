part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final Registration registration;
  final List<String> genres = [
    'Horror',
    'Music',
    'Action',
    'Drama',
    'War',
    'Crime'
  ];
  final List<String> languages = ['Bahasa', 'English', 'Japanese', 'Korean'];

  PreferencePage(this.registration);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  @override
  Widget build(BuildContext context) {
    print(widget.registration.email);
    return WillPopScope(
        onWillPop: () {
          context
              .bloc<RegistrationPageBloc>()
              .add(GotoRegistrationPage(widget.registration));
          return;
        },
        child: BlocListener<PreferenceBloc, PreferenceState>(
          listener: (context, state) {
            if (state is OnPreferenceSubmit) {
              widget.registration.selectedGenres =
                  state.registration.selectedGenres;
              widget.registration.selectedLanguage =
                  state.registration.selectedLanguage;
              context
                  .bloc<RegistrationPageBloc>()
                  .add(GotoAccountConfPage(widget.registration));
            } else if (state is OnPreferenceError) {
              Flushbar(
                duration: Duration(seconds: 3),
                message: state.message,
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: accentColor6,
              ).show(context);
            }
          },
          child: Scaffold(
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 56,
                        margin: EdgeInsetsDirectional.only(top: 20, bottom: 4),
                        child: GestureDetector(
                          child: Icon(Icons.arrow_back),
                          onTap: () => context
                              .bloc<RegistrationPageBloc>()
                              .add(GotoRegistrationPage(widget.registration)),
                        ),
                      ),
                      Text('Select Your\nFavorite Genre',
                          style: blackTextFont.copyWith(fontSize: 20)),
                      SizedBox(height: 16),
                      Wrap(
                          spacing: 24,
                          runSpacing: 24,
                          children: generateGenresWidget()),
                      SizedBox(height: defaultMargin),
                      Text('Movie Language\nYou Prefer?',
                          style: blackTextFont.copyWith(fontSize: 20)),
                      SizedBox(height: 16),
                      Wrap(
                          spacing: 24,
                          runSpacing: 24,
                          children: generateLanguagesWidget()),
                      SizedBox(height: 30),
                      Center(
                        child: FloatingActionButton(
                          onPressed: () {
                            context
                                .bloc<PreferenceBloc>()
                                .add(PreferenceSubmit());
                          },
                          elevation: 0,
                          backgroundColor: mainColor,
                          child: Icon(Icons.arrow_forward),
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  List<Widget> generateGenresWidget() {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.genres
        .map((e) => StreamBuilder<List<String>>(
            stream: context.bloc<PreferenceBloc>().selectedGenresStream,
            initialData: [],
            builder: (context, snapshot) {
              return SelectableBox(
                e,
                width: width,
                height: width / 2 - 12,
                isSelected: snapshot.data.contains(e),
                onTap: () => onSelectedGenre(snapshot.data, e),
              );
            }))
        .toList();
  }

  void onSelectedGenre(List<String> data, String genre) {
    if (data.contains(genre)) {
      context.bloc<PreferenceBloc>().removeSelectedGenres(genre);
    } else {
      if (data.length < 4) {
        context.bloc<PreferenceBloc>().changeSelectedGenres(genre);
      }
    }
  }

  List<Widget> generateLanguagesWidget() {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.languages
        .map((e) => StreamBuilder<String>(
            stream: context.bloc<PreferenceBloc>().selectedLanguageStream,
            builder: (context, snapshot) {
              return SelectableBox(e,
                  width: width,
                  height: width / 2 - 12,
                  isSelected: snapshot.data == e,
                  onTap: () =>
                      context.bloc<PreferenceBloc>().changeSelectedLanguage(e));
            }))
        .toList();
  }
}
