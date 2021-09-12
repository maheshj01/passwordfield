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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: Colors.grey,
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
                  controller: TextEditingController(text: 'password'),
                  errorMessage:
                      'required at least 1 letter and number 5+ chars',
                  pattern: r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,}$',
                  inputDecoration: PasswordDecoration(
                    inputStyle: const TextStyle(
                      fontSize: 14,
                    ),
                    hintText: 'Password',
                  ),
                  border: PasswordBorder(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(width: 2, color: Colors.red),
                    ),
                  ),
                  suffixIconEnabled: true,
                ),
                // hasFloatingPlaceholder: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PasswordField(
                  color: Colors.green,
                  // hasFloatingPlaceholder: true,
                  pattern: r'.*[@$#.*].*',
                  // border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(2),
                  //     borderSide: BorderSide(width: 2, color: Colors.purple)),
                  // focusedBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //     borderSide: BorderSide(width: 2, color: Colors.purple)),
                  errorMessage:
                      'must contain special character either . * @ # \$',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 16),
              //   child: PasswordField(
              //     inputStyle: TextStyle(fontSize: 26),
              //     backgroundColor: Colors.blue[50],
              //     backgroundBorderRadius: BorderRadius.circular(20),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: const PasswordField(
              //     hintText: 'hold icon to see the password ',
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: PasswordField(
              //     color: Colors.deepPurple,
              //     hasFloatingPlaceholder: true,
              //     pattern: r'.*[@$#.*].*',
              //     errorMaxLines: 3,
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(2),
              //         borderSide: const BorderSide(width: 2, color: Colors.purple)),
              //     focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //         borderSide: const BorderSide(width: 2, color: Colors.purple)),
              //     errorStyle: const TextStyle(color: Colors.green, fontSize: 18),
              //     errorMessage:
              //         'Add Your Custom error Message as long as you want and With your custom style with a property called errorStyle',
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PasswordField(
                  backgroundColor: Colors.grey,
                  backgroundBorderRadius: BorderRadius.circular(20),
                  inputDecoration: PasswordDecoration(
                    inputPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Password',
                    inputStyle: const TextStyle(
                        fontSize: 16.0, color: Color(0xFFbdc6cf)),
                  ),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  suffixIconEnabled: false,
                  border: PasswordBorder(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(25.7)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
