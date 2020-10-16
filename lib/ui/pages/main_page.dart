part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavBarIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();

    bottomNavBarIndex = 0;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: accentColor1,
          ),
          SafeArea(
            child: Container(
              color: Color(0xFFE5E5E5),
            ),
          ),
          PageView(
            controller: pageController,
            children: [
              MoviesPage(),
              Center(child: Text('My Tickets')),
            ],
            onPageChanged: (index) {
              setState(() {
                bottomNavBarIndex = index;
              });
            },
          ),
          createCustomBottomNavBar(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 46,
              width: 46,
              margin: EdgeInsets.only(bottom: 42),
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: accentColor2,
                child: Icon(
                  Icons.download_rounded,
                  color: Colors.black.withOpacity(0.54),
                  size: 26,
                ),
                onPressed: () {
                  context.bloc<UserBloc>().add(SignOut());
                  AuthServices.signOut();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget createCustomBottomNavBar() => Align(
        alignment: Alignment.bottomCenter,
        child: ClipPath(
          clipper: BottomNavBarClipper(),
          child: Container(
            height: 65,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: BottomNavigationBar(
              selectedLabelStyle: GoogleFonts.raleway(color: Colors.black),
              unselectedLabelStyle:
                  GoogleFonts.raleway(color: Color(0xFFE0E0E0)),
              backgroundColor: Colors.transparent,
              elevation: 0,
              currentIndex: bottomNavBarIndex,
              selectedItemColor: Color(0xFF503E9D),
              unselectedItemColor: Color(0xFFE0E0E0),
              onTap: (index) {
                setState(() {
                  bottomNavBarIndex = index;
                  pageController.jumpToPage(bottomNavBarIndex);
                });
              },
              items: [
                BottomNavigationBarItem(
                    label: 'New Movies',
                    icon: Container(
                      margin: EdgeInsets.only(bottom: 6),
                      height: 20,
                      child: Image.asset(
                        (bottomNavBarIndex == 0)
                            ? 'assets/ic_movie.png'
                            : 'assets/ic_movie_grey.png',
                        width: 24,
                        height: 18,
                      ),
                    )),
                BottomNavigationBarItem(
                    label: 'My Tickets',
                    icon: Container(
                      margin: EdgeInsets.only(bottom: 6),
                      height: 20,
                      child: Image.asset(
                        (bottomNavBarIndex == 1)
                            ? 'assets/ic_tickets.png'
                            : 'assets/ic_tickets_grey.png',
                        width: 24,
                        height: 18,
                      ),
                    ))
              ],
            ),
          ),
        ),
      );
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
