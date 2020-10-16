import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutix/models/models.dart';
import 'package:rxdart/rxdart.dart';

part 'preference_event.dart';
part 'preference_state.dart';

class PreferenceBloc extends Bloc<PreferenceEvent, PreferenceState> {
  PreferenceBloc() : super(PreferenceInitial()) {
    selectedGenresController.sink.add([]);
  }

  final selectedGenresController = BehaviorSubject<List<String>>();
  final selectedLanguageController = BehaviorSubject<String>();

  Stream<List<String>> get selectedGenresStream =>
      selectedGenresController.stream;

  Stream<String> get selectedLanguageStream =>
      selectedLanguageController.stream;

  void changeSelectedGenres(String value) {
    selectedGenresController.value.add(value);
    selectedGenresController.sink.add(selectedGenresController.value);
  }

  void removeSelectedGenres(String value) {
    selectedGenresController.value.remove(value);
    selectedGenresController.sink.add(selectedGenresController.value);
  }

  Function(String) get changeSelectedLanguage =>
      selectedLanguageController.sink.add;

  List<String> get selectedGenres => selectedGenresController.value;

  String get selectedLanguage => selectedLanguageController.value;

  @override
  Stream<PreferenceState> mapEventToState(
    PreferenceEvent event,
  ) async* {
    if (event is PreferenceSubmit) {
      if (selectedGenres.length != 4 || selectedLanguage.isEmpty) {
        yield OnPreferenceError('Please select 4 genres');
      } else if (selectedLanguage.isEmpty) {
        yield OnPreferenceError('Please select language');
      } else {
        Registration registration = Registration(
            selectedGenres: selectedGenres, selectedLanguage: selectedLanguage);
        yield OnPreferenceSubmit(registration);
      }
    }
  }

  dispose() {
    selectedGenresController.close();
    selectedLanguageController.close();
  }
}
