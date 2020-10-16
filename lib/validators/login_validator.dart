part of 'validators.dart';

class LoginValidator {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (e, sink) {
    if (EmailValidator.validate(e)) {
      sink.add(e);
    } else {
      sink.addError('Email not valid');
    }
  });

  final validatePassword =
      StreamTransformer<String, String>.fromHandlers(handleData: (p, sink) {
    if (p.length >= 6) {
      sink.add(p);
    } else {
      sink.addError('Minimum password 6');
    }
  });
}
