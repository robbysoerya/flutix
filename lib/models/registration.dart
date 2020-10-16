part of 'models.dart';

class Registration {
  String email;
  String name;
  String password;
  PickedFile profileImage;
  List<String> selectedGenres;
  String selectedLanguage;

  Registration({
    this.email,
    this.password,
    this.name,
    this.profileImage,
    this.selectedGenres,
    this.selectedLanguage,
  });
}
