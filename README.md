#  passwordfield: [^0.1.0](https://pub.dev/packages/passwordfield) 



A simple and easy to use flutter package to add a passwordfield to your Flutter project.

## Getting Started

### Installation

- Add the dependency
```
dependencies:
  passwordfield: ^0.1.0
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


## Now Supports adding constraints on the Password 

![Screenshot from 2020-01-11 22-16-13](https://user-images.githubusercontent.com/31410839/72208800-2ca25e80-34cd-11ea-9cc2-8dd1274ff975.png)


- Example 1         
```
    return Scaffold(
        backgroundColor: Colors.green,
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Center(
              child: PasswordField(
              color: Colors.green,
              hasFloatingPlaceholder: true,
              pattern: r'.*[@$#.*].*',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(width: 2, color: Colors.green)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 2, color: Colors.green)),
              errorMessage: 'must contain special character either . * @ # \$',
              ),
             )));
```
<img src="https://user-images.githubusercontent.com/31410839/81468422-17300d80-91fd-11ea-9814-36947bf68a1b.png" width=400>

- Example 2

```
      Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: PasswordField(
              inputStyle: TextStyle(fontSize: 26),
              suffixIcon: Icon(
                Icons.smartphone,
                color: Colors.red,
              ),
              textPadding: EdgeInsets.symmetric(horizontal: 20),
              backgroundColor: Colors.blue[50],
              backgroundBorderRadius: BorderRadius.circular(20),
            ),
          ),
```


<img src="https://user-images.githubusercontent.com/31410839/72208790-15637100-34cd-11ea-82c8-2d8e92ac068f.gif" width=290>        <img src="https://user-images.githubusercontent.com/31410839/81469769-8c531100-9204-11ea-85ab-47570ecadf84.png" width=350>

refer: [for more examples](https://github.com/maheshmnj/passwordfield-flutter-package/example)

## features

```bool autoFocus```: if autofocus is true keyboard pops up as soon as the widget is rendered on screen defaults to false

```PasswordDecoration inputDecoration```: Decoration class for the PasswordField to customize the input styling

```PasswordBorder border```:  Border class for the passwordfield which provides borders for different states of the passwordfield
                               e.g [enabledBorder],[border], [focusedBorder], [focusedErrorBorder]

```TextEditingController controller```: A controller for an editable passwordfield.

```InputBorder errorFocusedBorder```: Input Border for the password Field when in Focus and has an error

```String errorMessage```: custom message to show if the input password does not match the pattern.

```TextStyle errorStyle```: text Styling to customise the errorMessage.

```String floatingText```: floatingText to show when floatingPlaceholder is true;

```InputBorder focusedBorder```: Input Border for the password Field when in Focus

```bool hasFloatingPlaceholder```: whether the placeholder can float to left top on focus

```final TextStyle hintStyle```: styling the hint defaults to same as inputStyle if not specified

```final String hintText```:hint to show if the placeholder is false

```TextStyle inputStyle```: styling the passwordfield Text;

```int maxLength```: the max number of characters the password field can support
  
``` Function onSubmit```: function triggerred when the submit button on keyboard is pressed

```String pattern```: supports adding constraints to the Passwordfield by adding a regex pattern
  
``` Icon suffixIcon```: Icon used to unhide the password when touch in Contact with the icon
  
```bool suffixIconEnabled```: suffix Icon can be removed by setting suffixIconEnabled to false,defaults to true

you are welcome to contribute to this package,contribution doesnt necessarily mean sending a pull request it could be
 - pointing out bugs/issues 
 - requesting a new feature
 - improving the documentation
 if you feel generous and confident send a PR :) 
