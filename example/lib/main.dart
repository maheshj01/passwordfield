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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.red,
          colorScheme:
              ThemeData.light().colorScheme.copyWith(primary: Colors.red)),
      home: PasswordApp(),
    );
  }
}

class PasswordApp extends StatelessWidget {
  /// TODO: Add examples in readme with gifs

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
                  inputDecoration: PasswordDecoration(
                    inputPadding: const EdgeInsets.symmetric(horizontal: 10),
                    suffixIcon: const Icon(
                      Icons.not_accessible,
                      color: Colors.grey,
                    ),
                    inputStyle: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  hintText: 'Password',
                  onChanged: (x) {
                    print(x);
                  },
                  border: PasswordBorder(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(width: 2, color: Colors.red.shade200),
                    ),
                  ),
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
                  inputDecoration: PasswordDecoration(),
                  // hintText: 'must have special characters',
                  border: PasswordBorder(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue.shade100,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue.shade100,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(width: 2, color: Colors.red.shade200),
                    ),
                  ),
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
                  inputDecoration: PasswordDecoration(
                    inputPadding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  border: PasswordBorder(
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 0, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25.7)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.grey),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.grey),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
