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
    // print('pattern=$pattern' +  ' $password');
    final RegExp regex = RegExp('''$pattern''');
    if (regex.hasMatch(password)) {
      // print('match');
      sink.add(password);
    } else {
      // print('unmatch');
      sink.addError('Invalid password format :(');
    }
  });
}
