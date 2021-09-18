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
```dart
    return Scaffold(
        backgroundColor: Colors.green,
        body: PasswordField(
                color: Colors.blue,
                pattern: r'.*[@$#.*].*',
                inputDecoration: PasswordDecoration(),
                hintText: 'must have special characters',
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
                errorMessage:'must contain special character either . * @ # \$',
              ),
      );
```

### [More examples here 👈](example/lib/main.dart)

## features

```bool autoFocus```: if autofocus is true keyboard pops up as soon as the widget is rendered on screen defaults to false

```Color backgroundColor``` Background Color for the textfield (defaults to white), By default the backgroundColor is based on the current [Theme].

```PasswordBorder border```:  Border class for the passwordfield which provides borders for different states of the passwordfield e.g [enabledBorder],[border], [focusedBorder], [focusedErrorBorder]

```TextEditingController controller```: A controller for an editable passwordfield.

```int errorMaxLines```: Defaults to null, which means that the [errorText] will be limited  to a single line with [TextOverflow.ellipsis]

```String errorMessage```: custom message to show if the input password does not match the pattern.

```String floatingText```: floatingText to show when floatingPlaceholder is true

```final String hintText```:hint to show if the placeholder is false

```PasswordDecoration inputDecoration```: Decoration class for the PasswordField to customize the input styling

```int maxLength```: the max number of characters the password field can support
  
```Function onSubmit```: function triggerred when the submit button on keyboard is pressed

```Function onChanged```: function triggerred when the password is changed in the passwordfield

```String pattern```: supports adding constraints to the Passwordfield by adding a regex pattern
  
You are welcome to contribute to this package, to contribute please read the [contributing guidelines](CONTRIBUTING.md).
