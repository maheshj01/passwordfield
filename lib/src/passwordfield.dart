library passwordfield;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:passwordfield/src/password_bloc.dart';

class PasswordField extends StatefulWidget {
  PasswordField(
      {Key? key,
      this.autoFocus = false,
      this.border,
      this.color,
      this.controller,
      this.floatingText,
      this.maxLength,
      this.errorMaxLines,
      this.onSubmit,
      this.backgroundColor,
      this.backgroundBorderRadius,
      this.onChanged,
      this.errorMessage,
      this.pattern,
      this.inputDecoration})
      : super(key: key);

  /// if autofocus is true keyboard pops up as soon as the widget is rendered on screen
  /// defaults to false
  final bool? autoFocus;

  /// changes the primary color of the PasswordField
  final Color? color;

  /// Background Color for the textfield must be specified with [backgroundBorderRadius]
  final Color? backgroundColor;

  /// Border for the textfield background must be specified with backgroundColor
  final BorderRadiusGeometry? backgroundBorderRadius;

  /// Input Border for the passwordfield
  final PasswordBorder? border;

  /// A controller for an editable passwordfield.
  final TextEditingController? controller;

  ///
  /// RegEx pattern for the input password
  ///
  ///     r'[a-zA-Z]'      // 'heLLo' allows Alphabets with upper and lower case
  ///     r'[a-zA-Z]{8}'   // 'helloYou' allows Alphabetic password strict to 8 chars
  ///     r'[0-9a-zA-Z]';  // 'Hello123' allows alphanumeric password
  ///     r'[0-9]{6}'      //  '123456' allows numeric password strict to 6 characters
  ///
  /// Dart regular expressions have the same syntax and semantics
  /// as JavaScript regular expressions.
  /// See:[ecma-international.org/ecma-262/9.0/#sec-regexp-regular-expression-objects](ecma-international.org/ecma-262/9.0/#sec-regexp-regular-expression-objects)
  /// for the specification of JavaScript regular expressions.
  ///
  /// By default the patter is set to `.*` allowing any characters
  final String? pattern;

  /// decoration for the input
  PasswordDecoration? inputDecoration;

  /// The maximum number of lines the [errorText] can occupy.
  ///
  /// Defaults to null, which means that the [errorText] will be limited
  /// to a single line with [TextOverflow.ellipsis].
  final int? errorMaxLines;

  /// custom message to show if the input password does not match the pattern.
  final String? errorMessage;

  /// if hasFloatingPlaceholder==true
  /// a text label floats to left top on focus
  /// The label defaults to "Password" if not specified,
  ///
  /// floating text can be styled using [hintStyle]
  ///
  /// Note: either [floatingText]/ [hintText] can be shown at a time
  /// that mainly depends on property [hasFloatingPlaceholder]
  final String? floatingText;

  /// the max number of characters the password field can support
  final int? maxLength;

  /// function triggerred when the submit button on keyboard is pressed
  final Function(String)? onSubmit;

  /// A Callback function triggered when the text inside the PasswordField changes
  ///
  final Function(String)? onChanged;

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

  InputDecoration _buildDefaultInputDecoration() {
    return InputDecoration(
        fillColor: widget.backgroundColor,
        filled: widget.backgroundColor != null,
        suffixIcon: GestureDetector(
          child: const Icon(Icons.remove_red_eye),
          onTapDown: inContact,
          onTapUp: outContact,
        ));
  }

  @override
  Widget build(BuildContext context) {
    const underlineBorder = UnderlineInputBorder();
    final defaultTextStyle = DefaultTextStyle.of(context).style;
    widget.inputDecoration?.inputStyle ??= defaultTextStyle;
    return Theme(
      data: ThemeData(
        primaryColor: widget.color ?? Theme.of(context).primaryColor,
        colorScheme: Theme.of(context)
            .colorScheme
            .copyWith(primary: widget.color ?? Theme.of(context).primaryColor),
      ),
      child: StreamBuilder<String>(
        stream: bloc.password,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextField(
              maxLength: widget.maxLength,
              controller: widget.controller,
              obscureText: obscureText,
              autofocus: widget.autoFocus!,
              decoration: widget.inputDecoration == null
                  ? _buildDefaultInputDecoration()
                  : widget.inputDecoration!.copyWith(
                      fillColor: widget.backgroundColor,
                      filled: widget.backgroundColor != null,
                      contentPadding: widget.inputDecoration!.inputPadding,
                      errorText: snapshot.hasError
                          ? widget.errorMessage ?? snapshot.error as String?
                          : null,
                      errorMaxLines: widget.errorMaxLines,
                      errorStyle: widget.inputDecoration!.errorStyle ??
                          defaultTextStyle.copyWith(color: Colors.red),
                      hintText: widget.inputDecoration!.hasFloatingPlaceholder
                          ? null
                          : widget.inputDecoration!.hintText,
                      hintStyle: widget.inputDecoration?.hintStyle ??
                          widget.inputDecoration?.inputStyle,
                      labelStyle: widget.inputDecoration!.hintStyle ??
                          widget.inputDecoration!.inputStyle,
                      border: widget.border == null
                          ? underlineBorder
                          : widget.border?.border,
                      enabledBorder: widget.border == null
                          ? underlineBorder
                          : widget.border?.enabledBorder,
                      focusedBorder: widget.border == null
                          ? underlineBorder
                          : widget.border?.focusedBorder,
                      focusedErrorBorder: widget.border == null
                          ? null
                          : widget.border?.focusedErrorBorder,
                      errorBorder: widget.border == null
                          ? null
                          : widget.border!.errorBorder,
                      counterText: '',
                      floatingLabelBehavior:
                          widget.inputDecoration!.hasFloatingPlaceholder
                              ? FloatingLabelBehavior.auto
                              : FloatingLabelBehavior.never,
                      labelText: widget.inputDecoration!.hasFloatingPlaceholder
                          ? widget.floatingText ?? 'Password'
                          : (widget.inputDecoration!.hintText ?? 'Password'),
                      suffixIcon: GestureDetector(
                        child: widget.inputDecoration!.suffixIcon,
                        onTapDown: inContact,
                        onTapUp: outContact,
                      )),
              onSubmitted: widget.onSubmit,
              style: widget.inputDecoration?.inputStyle,
              onChanged: (text) {
                bloc.onPasswordChanged(widget.pattern ?? '.*', text);
                if (widget.onChanged != null) {
                  widget.onChanged!(text);
                }
              });
        },
      ),
    );
  }
}

/// Decoration class for the PasswordField to customize the input styling
class PasswordDecoration extends InputDecoration {
  PasswordDecoration(
      {this.hasFloatingPlaceholder = false,
      this.hintText,
      this.hintStyle,
      this.inputStyle,
      this.errorStyle,
      this.inputPadding,
      this.suffixIcon = const Icon(Icons.remove_red_eye)});

  /// whether the placeholder can float to left top on focus
  final bool hasFloatingPlaceholder;

  ///default text to show on the passwordfield
  /// This hint is hidden/does not take effect if [hasFloatingPlaceholder] = true
  final String? hintText;

  /// styling fpr the the hint and the floating label,
  /// defaults to same as inputStyle if not specified
  final TextStyle? hintStyle;

  /// styling the Passwordfield Text
  TextStyle? inputStyle;

  /// style for the the errorMessage
  final TextStyle? errorStyle;

  /// Input padding
  final EdgeInsetsGeometry? inputPadding;

  /// Icon used to unhide the password when touch in Contact with the icon
  final Icon? suffixIcon;
}

/// Consolidated Border class for the passwordfield
/// when not in focus
class PasswordBorder {
  PasswordBorder(
      {this.border,
      this.focusedBorder,
      this.enabledBorder,
      this.focusedErrorBorder});

  /// Input Border for the passwordfield when not in focus.
  InputBorder? border;

  ///  Input Border for the passwordfield when field is not disabled.
  InputBorder? enabledBorder;

  ///  Input Border for the passwordfield when field is unfocused and has error.
  InputBorder? errorBorder;

  ///  Input Border for the passwordfield when field is focused and has error.
  InputBorder? focusedErrorBorder;

  ///  Input Border for the passwordfield when in focus.
  InputBorder? focusedBorder;
}
