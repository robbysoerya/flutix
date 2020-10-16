part of 'pages.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        decoration: BoxDecoration(
          color: accentColor1,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 20),
        child: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
          if (userState is UserLoaded) {
            return Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF5F558B)),
                  ),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: (userState.user.profilePicture == null)
                                ? AssetImage('assets/user_pic.png')
                                : NetworkImage(userState.user.profilePicture))),
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 124,
                      child: Text(userState.user.name,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: whiteTextFont.copyWith(fontSize: 18)),
                    ),
                    SizedBox(height:4),
                    Text(
                        NumberFormat.currency(
                                locale: 'id_ID',
                                decimalDigits: 0,
                                symbol: 'IDR ')
                            .format(userState.user.balance),
                        style: yellowNumberFont)
                  ],
                ),
              ],
            );
          } else {
            return Container();
          }
        }),
      )
    ]);
  }
}
