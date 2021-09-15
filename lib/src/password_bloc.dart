import 'dart:async';

class PasswordBloc extends Validation {
  final _passwordController = StreamController<List<String>>.broadcast();

// validating the password
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  void onPasswordChanged(String pattern, String text) {
    final List<String> list = [pattern, text];
    _passwordController.sink.add(list);
  }

  void dispose() {
    _passwordController.close();
  }
}

class Validation {
  var validatePassword = StreamTransformer<List<String>, String>.fromHandlers(
      handleData: (list, sink) {
    final String pattern = list[0];
    final String password = list[1];
    final RegExp regex = RegExp('''$pattern''');
    final int minLength = 8;
    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > minLength;

    if (pattern.isEmpty) {
      /// Default Pattern
      if (hasDigits &
          hasUppercase &
          hasLowercase &
          hasSpecialCharacters &
          hasMinLength) {
        sink.add(password);
      } else {
        sink.addError('Invalid password format :(');
      }
    } else {
      if (regex.hasMatch(password)) {
        sink.add(password);
      } else {
        sink.addError('Invalid password format :(');
      }
    }
  });
}
