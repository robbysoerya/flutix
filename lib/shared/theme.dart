part of 'shared.dart';

const double defaultMargin = 24;

Color mainColor = Color(0xFF503E9D);
Color accentColor1 = Color(0xFF2C1F63);
Color accentColor2 = Color(0xFFF8D460);
Color accentColor3 = Color(0xFFADADAD);
Color accentColor4 = Color(0xFFE4E4E4);
Color accentColor5 = Color(0xFFBEBEBE);
Color accentColor6 = Color(0xFFFF5C83);
Color accentColor7 = Color(0xFFE5E5E5);

TextStyle blackTextFont = GoogleFonts.raleway()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);
TextStyle whiteTextFont = GoogleFonts.raleway()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle purpleTextFont = GoogleFonts.raleway()
    .copyWith(color: mainColor, fontWeight: FontWeight.w500);
TextStyle greyTextFont = GoogleFonts.raleway()
    .copyWith(color: accentColor3, fontWeight: FontWeight.w500);

TextStyle whiteNumberFont =
    GoogleFonts.openSans().copyWith(color: Colors.white);

TextStyle yellowNumberFont =
    GoogleFonts.openSans().copyWith(color: accentColor2);
