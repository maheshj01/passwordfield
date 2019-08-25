# passwordfield

A simple and easy to use flutter package to add a passwordfield to your Flutter project.

## Getting Started

### Installation

- Add the dependency
```
dependencies:
  passwordfield: ^0.1.1
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
    return Scaffold(
        backgroundColor: Colors.green,
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Center(
              child: PasswordField(
                color: Colors.white,
                inputStyle: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
                hintText: "password field",
              ),
            )));
```
more customizations to be made soon

your welcome to contribute to this package All you need to do is 
 - fork
 - contribute
 - send a pull request
