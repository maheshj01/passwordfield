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
      this.hintText,
      this.hintStyle,
      this.inputStyle,
      this.floatingText,
      this.maxLength,
      this.errorMaxLines,
      this.onSubmit,
      this.backgroundColor,
      this.backgroundBorderRadius,
      this.textPadding,
      this.errorStyle,
      @deprecated this.onChanged,
      this.errorFocusedBorder,
      this.errorMessage,
      this.suffixIcon,
      this.pattern,
      this.suffixIconEnabled = true})
      : assert((backgroundColor == null && backgroundBorderRadius == null) ||
            (backgroundColor != null && backgroundBorderRadius != null));
  // assert((hasFloatingPlaceholder == true && hintText == null) ||
  //     (hasFloatingPlaceholder == false && hintText != null));

  /// if autofocus is true keyboard pops up as soon as the widget is rendered on screen
  /// defaults to false
  final bool autoFocus;

  /// Input Border for the password field when not in focus
  final InputBorder border;

  /// changes the primary color of the PasswordField
  final Color color;

  /// Background Color for the textfield must be specified with [backgroundBorderRadius]
  final Color backgroundColor;

  /// Border for the textfield background must be specified with backgroundColor
  final BorderRadiusGeometry backgroundBorderRadius;

  /// Input Border for the password Field when in Focus
  final InputBorder focusedBorder;

  /// Input Border for the password Field when in Focus and has an error
  final InputBorder errorFocusedBorder;

  /// paddint for the textfield when [backgroundBorderRadius] != null
  final EdgeInsetsGeometry textPadding;

  /// A controller for an editable passwordfield.
  final TextEditingController controller;

  /**
   * RegEx pattern for the input password
   *
   *     r'[a-zA-Z]'      // 'heLLo' allows Alphabets with upper and lower case
   *     r'[a-zA-Z]{8}'   // 'helloYou' allows Alphabetic password strict to 8 chars
   *     r'[0-9a-zA-Z]';  // 'Hello123' allows alphanumeric password
   *     r'[0-9]{6}'      //  '123456' allows numeric password strict to 6 characters
   *
   * Dart regular expressions have the same syntax and semantics 
   * as JavaScript regular expressions. 
   * See:[ecma-international.org/ecma-262/9.0/#sec-regexp-regular-expression-objects](ecma-international.org/ecma-262/9.0/#sec-regexp-regular-expression-objects)
   * for the specification of JavaScript regular expressions.
   */
  final String pattern;

  /// whether the placeholder can float to left top on focus
  final bool hasFloatingPlaceholder;

  ///default text to show on the passwordfield
  /// This hint is hidden/does not take effect if [hasFloatingPlaceholder] = true
  final String hintText;

  /// styling fpr the the hint and the floating label,
  /// defaults to same as inputStyle if not specified
  final TextStyle hintStyle;

  /// styling the Passwordfield Text
  final TextStyle inputStyle;

  /// style for the the errorMessage
  final TextStyle errorStyle;

  /// The maximum number of lines the [errorText] can occupy.
  ///
  /// Defaults to null, which means that the [errorText] will be limited
  /// to a single line with [TextOverflow.ellipsis].
  final int errorMaxLines;

  /// custom message to show if the input password does not match the pattern.
  final String errorMessage;

  /// if hasFloatingPlaceholder==true
  /// a text label floats to left top on focus
  /// The label defaults to "Password" if not specified,
  ///
  /// floating text can be styled using [hintStyle]
  ///
  /// Note: either [floatingText]/ [hintText] can be shown at a time
  /// that mainly depends on property [hasFloatingPlaceholder]
  final String floatingText;

  /// the max number of characters the password field can support
  final int maxLength;

  /// function triggerred when the submit button on keyboard is pressed
  final Function(String) onSubmit;

  /// A Callback function triggered when the text insude the PasswordField changes
  ///
  @deprecated
  final Function onChanged;

  /// Icon used to unhide the password when touch in Contact with the icon
  final Icon suffixIcon;

  /// The Icon to show at the right end of the textfield, suffix Icon can be removed by setting suffixIconEnabled to false,defaults to true
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
          return Container(
            padding: widget.backgroundColor != null ? widget.textPadding : null,
            decoration: widget.backgroundColor != null
                ? BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius: widget.backgroundBorderRadius)
                : null,
            child: TextField(
              maxLength: widget.maxLength,
              controller: widget.controller,
              obscureText: obscureText,
              autofocus: widget.autoFocus,
              decoration: InputDecoration(
                  border: widget.backgroundColor != null
                      ? InputBorder.none
                      : widget.border,
                  errorText: snapshot.hasError
                      ? widget.errorMessage ?? snapshot.error
                      : null,
                  errorMaxLines: widget.errorMaxLines,
                  errorStyle: widget.errorStyle,
                  enabledBorder: widget.border,
                  focusedBorder: widget.focusedBorder,
                  hintText:
                      widget.hasFloatingPlaceholder ? null : widget.hintText,
                  hintStyle: widget.hintStyle ?? widget.inputStyle,
                  counterText: '',
                  focusedErrorBorder: widget.errorFocusedBorder,
                  floatingLabelBehavior: widget.hasFloatingPlaceholder
                      ? FloatingLabelBehavior.auto
                      : FloatingLabelBehavior.never,
                  labelText: widget.hasFloatingPlaceholder
                      ? widget.floatingText ?? 'Password'
                      : (widget.hintText ?? 'Password'),
                  labelStyle: widget.hintStyle ?? widget.inputStyle,
                  suffixIcon: widget.suffixIconEnabled
                      ? GestureDetector(
                          child:
                              widget.suffixIcon ?? Icon(Icons.remove_red_eye),
                          onTapDown: inContact,
                          onTapUp: outContact,
                        )
                      : null),
              onSubmitted: widget.onSubmit,
              style: widget.inputStyle,
              onChanged: (text) =>
                  bloc.onPasswordChanged(widget.pattern ?? '.*', text),
            ),
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
