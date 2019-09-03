library passwordfield;

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  //if autofocus is true keyboard pops up as soon as the widget is rendered on screen
  // defaults to false
  final bool autoFocus;
  // Input Border for the password Field
  final InputBorder border;
  //changes the primary color of the PasswordField
  final Color color;
  // A controller for an editable passwordfield.
  final TextEditingController controller;
  final bool hasFloatingPlaceholder;
  final String hintText;
  // styling the hint defaults to same as inputStyle if not specified
  final TextStyle hintStyle;
  // styling the passwordfield Text
  final TextStyle inputStyle;
  final int maxLength;
  // function triggerred when the submit button on keyboard is pressed
  final Function onSubmit;
  // function triggered when the text inside the passwordField is changed
  final Function onChanged;
  //Icon used to unhide the password when touch in Contact with the icon
  final Icon suffixIcon;
  // suffix Icon can be removed by setting suffixIconEnabled to false,defaults to true
  final bool suffixIconEnabled;

  PasswordField(
      {this.autoFocus = false,
      this.border,
      this.color,
      this.controller,
      this.hasFloatingPlaceholder = false,
      this.hintText = "",
      this.hintStyle,
      this.inputStyle,
      this.maxLength,
      this.onSubmit,
      this.onChanged,
      this.suffixIcon,
      this.suffixIconEnabled = true});
  @override
  State createState() {
    return PasswordFieldState();
  }
}

class PasswordFieldState extends State<PasswordField> {
  TextEditingController controller = new TextEditingController();
  bool obscureText = true;
//wrap your toggle icon in Gesture Detector

  void inContact(TapDownDetails details) {
    setState(() {
      obscureText = false;
    });
  }

  void outContact(TapUpDetails details) {
    setState(() {
      obscureText = true;
    });
  }

  Widget passwordFieldWidget() {
    return Theme(
      data: ThemeData(
          primaryColor:
              widget.color ?? Theme.of(context).primaryColor ?? Colors.red),
      child: TextField(
        maxLength: widget.maxLength,
        controller: widget.controller,
        obscureText: obscureText,
        autofocus: widget.autoFocus,
        decoration: InputDecoration(
          border: widget.border,
            hintText: widget.hasFloatingPlaceholder ? null : widget.hintText,
            hintStyle: widget.hintStyle ?? widget.inputStyle,
            counterText: '',
            hasFloatingPlaceholder: widget.hasFloatingPlaceholder,
            labelText: widget.hasFloatingPlaceholder ? "Password" : null,
            suffixIcon: widget.suffixIconEnabled
                ? GestureDetector(
                    child: widget.suffixIcon ?? Icon(Icons.remove_red_eye),
                    onTapDown: inContact,
                    onTapUp: outContact,
                  )
                : null),
        onSubmitted: widget.onSubmit,
        style: widget.inputStyle,
        onChanged: widget.onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return passwordFieldWidget();
  }
}
