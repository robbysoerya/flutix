part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(User user) async {
    String genres = user.selectedGenres.join(',');

    _userCollection.doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenres': genres,
      'selectedLanguage': user.selectedLanguage,
      'profilePicture': user.profilePicture ?? ''
    });
  }

  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    return User(id, snapshot.get('email'),
        name: snapshot.get('name'),
        balance: snapshot.get('balance'),
        selectedGenres: snapshot.get('selectedGenres').toString().split(','),
        selectedLanguage: snapshot.get('selectedLanguage'));
  }
}
