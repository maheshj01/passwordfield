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
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: PasswordField(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      )),
                  suffixIconEnabled: true,
                  hasFloatingPlaceholder: false,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.white, width: 3)),
                  color: Colors.black,
                  inputStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  hintText: "Password",
                ),
              ),
            ],
          )),
    );
  }
}
