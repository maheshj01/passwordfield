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
      @deprecated this.onChanged,
      this.errorMessage,
      this.suffixIcon,
      this.pattern,
      this.suffixIconEnabled = true,
      this.inputDecoration})
      : assert(border != null ||
            ((backgroundColor == null && backgroundBorderRadius == null) ||
                (backgroundColor != null && backgroundBorderRadius != null))),
        super(key: key);

  // assert((hasFloatingPlaceholder == true && hintText == null) ||
  //     (hasFloatingPlaceholder == false && hintText != null));

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

  /// A Callback function triggered when the text insude the PasswordField changes
  ///
  @deprecated
  final Function? onChanged;

  /// Icon used to unhide the password when touch in Contact with the icon
  final Icon? suffixIcon;

  /// The Icon to show at the right end of the textfield, suffix Icon can be removed by setting suffixIconEnabled to false,defaults to true
  final bool? suffixIconEnabled;

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

  @override
  Widget build(BuildContext context) {
    final noneBorder = InputBorder.none;
    final defaultTextStyle = DefaultTextStyle.of(context).style;
    widget.inputDecoration?.inputStyle ??= defaultTextStyle;
    return Theme(
      data: ThemeData(
          primaryColor: widget.color ?? Theme.of(context).primaryColor),
      child: StreamBuilder<String>(
        stream: bloc.password,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextField(
            maxLength: widget.maxLength,
            controller: widget.controller,
            obscureText: obscureText,
            autofocus: widget.autoFocus!,
            decoration: widget.inputDecoration == null
                ? null
                : widget.inputDecoration!.copyWith(
                    fillColor: widget.color,
                    filled: true,
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
                        ? noneBorder
                        : widget.border?.border,
                    enabledBorder: widget.border == null
                        ? noneBorder
                        : widget.border?.enabledBorder,
                    focusedBorder: widget.border == null
                        ? noneBorder
                        : widget.border?.focusedBorder,
                    focusedErrorBorder: widget.border == null
                        ? noneBorder
                        : widget.border?.focusedErrorBorder,
                    counterText: '',
                    floatingLabelBehavior:
                        widget.inputDecoration!.hasFloatingPlaceholder
                            ? FloatingLabelBehavior.auto
                            : FloatingLabelBehavior.never,
                    labelText: widget.inputDecoration!.hasFloatingPlaceholder
                        ? widget.floatingText ?? 'Password'
                        : (widget.inputDecoration!.hintText ?? 'Password'),
                    suffixIcon: widget.suffixIconEnabled!
                        ? GestureDetector(
                            child:
                                widget.suffixIcon ?? Icon(Icons.remove_red_eye),
                            onTapDown: inContact,
                            onTapUp: outContact,
                          )
                        : null),
            onSubmitted: widget.onSubmit,
            style: widget.inputDecoration?.inputStyle,
            onChanged: (text) =>
                bloc.onPasswordChanged(widget.pattern ?? '.*', text),
          );
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
      this.inputPadding});

  /// whether the placeholder can float to left top on focus
  final bool hasFloatingPlaceholder;

  ///default text to show on the passwordfield
  /// This hint is hidden/does not take effect if [hasFloatingPlaceholder] = true
  final String? hintText;

  /// styling fpr the the hint and the floating label,
  /// defaults to same as inputStyle if not specified
  final TextStyle? hintStyle;

  /// styling the Passwordfield Text
  late final TextStyle? inputStyle;

  /// style for the the errorMessage
  final TextStyle? errorStyle;

  /// Input padding
  final EdgeInsetsGeometry? inputPadding;
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

  ///  Input Border for the passwordfield when in focus.
  InputBorder? focusedBorder;

  ///  Input Border for the passwordfield when field has error.
  InputBorder? focusedErrorBorder;
}
