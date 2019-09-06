#  passwordfield: [^0.0.4](https://pub.dev/packages/passwordfield) 



A simple and easy to use flutter package to add a passwordfield to your Flutter project.

## Getting Started

### Installation

- Add the dependency
```
dependencies:
  passwordfield: ^0.0.4
  flutter:
```
- Import the package
```
import 'package:passwordfield/passwordfield.dart';
```
- Voila! use the Widget
```
PasswordField();
```
Note : The widget must be included in a Material Widget normally in a Scaffold,Card,Drawer etc

- Example
```
          PasswordField(
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
```                
```
    return Scaffold(
        backgroundColor: Colors.green,
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Center(
              child: PasswordField(
                color: Colors.white,
                inputStyle: TextStyle(fontSize: 30),
                hintText: "password field",
              ),
            )));
```
![](https://user-images.githubusercontent.com/31410839/64446788-54d11980-d0f7-11e9-8687-88039658e64a.gif)

you are welcome to contribute to this package All you need to do is 
 - fork
 - contribute
 - send a pull request
 - or Create Issues 
