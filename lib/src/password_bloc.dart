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
    const int minLength = 8;
    final bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final bool hasDigits = password.contains(RegExp(r'[0-9]'));
    final bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    final bool hasSpecialCharacters =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    final bool hasMinLength = password.length > minLength;

    if (pattern.isEmpty) {
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
