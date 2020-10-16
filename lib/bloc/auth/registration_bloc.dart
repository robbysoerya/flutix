import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutix/validators/validators.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    confPasswordStream.listen((value) {
      if (value != passwordController.value && value.isNotEmpty) {
        confPasswordController.addError('Password doesn\'t match');
      }
    });
  }

  final nameController = BehaviorSubject<String>();
  final emailController = BehaviorSubject<String>();
  final passwordController = BehaviorSubject<String>();
  final confPasswordController = BehaviorSubject<String>();
  final profileImageController = BehaviorSubject<PickedFile>();

  Stream<String> get nameStream => nameController.stream;
  Stream<String> get emailStream =>
      emailController.stream.transform(RegistrationValidator().validateEmail);
  Stream<String> get passwordStream => passwordController.stream
      .transform(RegistrationValidator().validatePassword);
  Stream<String> get confPasswordStream => confPasswordController.stream;
  Stream<PickedFile> get profileImageStream => profileImageController.stream;
  Stream<bool> get submitValid => CombineLatestStream.combine4(nameStream,
      emailStream, passwordStream, confPasswordStream, (a, b, c, d) => true);

  Function(String) get changeName => nameController.sink.add;
  Function(String) get changeEmail => emailController.sink.add;
  Function(String) get changePassword => passwordController.sink.add;
  Function(String) get changeConfPassword => confPasswordController.sink.add;
  Function(PickedFile) get changeProfileImage =>
      profileImageController.sink.add;

  String get name => nameController.value;
  String get email => emailController.value;
  String get password => confPasswordController.value;
  PickedFile get profileImage => profileImageController.value;

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is RegistrationSubmit) {
      if (email.isEmpty || name.isEmpty || password.isEmpty) {
        yield OnRegistrationError();
      } else {
        Registration registration = Registration(
            email: email,
            name: name,
            password: password,
            profileImage: profileImage);
        yield OnRegistrationSubmit(registration);
      }
    }
  }

  dispose() {
    nameController.close();
    emailController.close();
    passwordController.close();
    confPasswordController.close();
    profileImageController.close();
  }
}
