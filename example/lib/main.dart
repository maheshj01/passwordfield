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
      // theme: ThemeData.dark(),
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
          body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: const Text(
              'PasswordField: ^0.0.7',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: PasswordField(
              errorMessage: 'required at least 1 letter and number 5+ chars',
              pattern: r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,}$',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    width: 2,
                  )),
              suffixIconEnabled: true,
              // hasFloatingPlaceholder: true,
              inputStyle: const TextStyle(
                fontSize: 20,
              ),
              hintText: "Password",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PasswordField(
              color: Colors.green,
              hasFloatingPlaceholder: true,
              pattern: r'.*[@$#.*].*',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(width: 2, color: Colors.purple)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 2, color: Colors.purple)),
              errorMessage: 'must contain special character either . * @ # \$',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: PasswordField(
              inputStyle: TextStyle(fontSize: 26),
              backgroundColor: Colors.blue[50],
              backgroundBorderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const PasswordField(
              hintText: 'hold icon to see the password ',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PasswordField(
              color: Colors.deepPurple,
              hasFloatingPlaceholder: true,
              pattern: r'.*[@$#.*].*',
              errorMaxLines: 3,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: const BorderSide(width: 2, color: Colors.purple)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 2, color: Colors.purple)),
              errorStyle: const TextStyle(color: Colors.green, fontSize: 18),
              errorMessage:
                  'Add Your Custom error Message as long as you want and With your custom style with a property called errorStyle',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.transparent),
              child: TextField(
                autofocus: false,
                style:
                    const TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Username',
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
