import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeData = ThemeData(
        primarySwatch: Colors.blueGrey,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white54,
          focusColor: Colors.blue,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.primary),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: PasswordApp(),
    );
  }
}

class PasswordApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('PasswordField Demo'),
          ),
          body: ListView(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: PasswordField(
                  backgroundColor: Colors.red.shade100,
                  controller: TextEditingController(text: 'password'),
                  errorMessage:
                      'required at least 1 letter and number 5+ chars',
                  passwordConstraint: r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,}$',
                  hintText: 'Password',
                  onChanged: (x) {
                    print(x);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PasswordField(
                  color: Colors.blue,
                  passwordConstraint: r'.*[@$#.*].*',
                  errorMessage:
                      'must contain special character either . * @ # \$',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PasswordField(
                  backgroundColor: Colors.blue.withOpacity(0.2),
                  errorMessage: '''
- A uppercase letter
- A lowercase letter
- A digit
- A special character
- A minimum length of 8 characters
                 ''',
                  hintText: 'Default password constraint ',
                ),
              ),
            ],
          )),
    );
  }
}
