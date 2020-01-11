library passwordfield;

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:passwordfield/password_bloc.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {this.autoFocus = false,
      this.border,
      this.focusedBorder,
      this.color,
      this.controller,
      this.hasFloatingPlaceholder = false,
      this.hintText = '',
      this.hintStyle,
      this.inputStyle,
      this.maxLength,
      this.onSubmit,
      // this.onChanged,
      this.errorFocusedBorder,
      this.errorMessage,
      this.suffixIcon,
      this.pattern,
      this.suffixIconEnabled = true});

  //if autofocus is true keyboard pops up as soon as the widget is rendered on screen
  // defaults to false
  final bool autoFocus;
  // Input Border for the password field when not in focus
  final InputBorder border;
  //changes the primary color of the PasswordField
  final Color color;
  // Input Border for the password Field when in Focus
  final InputBorder focusedBorder;
  // Input Border for the password Field when in Focus and has an error
  final InputBorder errorFocusedBorder;
  // A controller for an editable passwordfield.
  final TextEditingController controller;
  // pattern for the input password
  final String pattern;
  // whether the placeholder can float to left top on focus
  final bool hasFloatingPlaceholder;
  // hint to show if the placeholder is false
  final String hintText;
  // styling the hint defaults to same as inputStyle if not specified
  final TextStyle hintStyle;
  // styling the passwordfield Text
  final TextStyle inputStyle;
  // custom message to show if the input password does not match the pattern.
  final String errorMessage;
  // the max number of characters the password field can support
  final int maxLength;
  // function triggerred when the submit button on keyboard is pressed
  final Function onSubmit;
  // function triggered when the text inside the passwordField is changed
  // #REMOVED final Function onChanged;
  //Icon used to unhide the password when touch in Contact with the icon
  final Icon suffixIcon;
  // suffix Icon can be removed by setting suffixIconEnabled to false,defaults to true
  final bool suffixIconEnabled;

  @override
  State createState() {
    return PasswordFieldState();
  }
}

class PasswordFieldState extends State<PasswordField> {
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

  PasswordBloc bloc = PasswordBloc();
  Widget passwordFieldWidget() {
    return Theme(
      data: ThemeData(
          primaryColor:
              widget.color ?? Theme.of(context).primaryColor ?? Colors.red),
      child: StreamBuilder<String>(
        stream: bloc.password,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextField(
            maxLength: widget.maxLength,
            controller: widget.controller,
            obscureText: obscureText,
            autofocus: widget.autoFocus,
            decoration: InputDecoration(
                border: widget.border,
                errorText: snapshot.hasError
                    ? widget.errorMessage ?? snapshot.error
                    : null,
                enabledBorder: widget.border,
                focusedBorder: widget.focusedBorder,
                hintText:
                    widget.hasFloatingPlaceholder ? null : widget.hintText,
                hintStyle: widget.hintStyle ?? widget.inputStyle,
                counterText: '',
                focusedErrorBorder: widget.errorFocusedBorder,
                hasFloatingPlaceholder: widget.hasFloatingPlaceholder,
                labelText: widget.hasFloatingPlaceholder ? 'Password' : null,
                suffixIcon: widget.suffixIconEnabled
                    ? GestureDetector(
                        child: widget.suffixIcon ?? Icon(Icons.remove_red_eye),
                        onTapDown: inContact,
                        onTapUp: outContact,
                      )
                    : null),
            onSubmitted: widget.onSubmit,
            style: widget.inputStyle,
            onChanged: (text) =>
                bloc.onPasswordChanged(widget.pattern ?? '.*', text),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return passwordFieldWidget();
  }
}
