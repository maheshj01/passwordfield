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
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              'PasswordField Examples',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: PasswordField(
              errorMessage: 'required at least 1 letter and number 5+ chars',
              pattern: r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,}$',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 2,
                  )),
              suffixIconEnabled: true,
              // hasFloatingPlaceholder: true,
              inputStyle: TextStyle(
                fontSize: 20,
              ),
              hintText: "Password",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
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
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: PasswordField(
              inputStyle: TextStyle(fontSize: 26),
              suffixIcon: Icon(
                Icons.smartphone,
                color: Colors.red,
              ),
              border: InputBorder.none,
              textPadding: EdgeInsets.symmetric(horizontal: 20),
              backgroundColor: Colors.blue[50],
              backgroundBorderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: PasswordField(
              hintText: 'hold icon to see the password ',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: PasswordField(
              color: Colors.deepPurple,
              hasFloatingPlaceholder: true,
              pattern: r'.*[@$#.*].*',
              errorMaxLines: 3,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(width: 2, color: Colors.purple)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 2, color: Colors.purple)),
              errorStyle: TextStyle(color: Colors.green, fontSize: 18),
              errorMessage:
                  'Add Your Custom error Message as long as you want and With your custom style with a property called errorStyle',
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      )),
    );
  }
}
