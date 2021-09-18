import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passwordfield/src/passwordfield.dart';

void main() {
  Widget _boilerplate({required Widget child}) {
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data: const MediaQueryData(size: Size(800.0, 600.0)),
          child: Center(
            key: const Key('centerKey'),
            child: Material(
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  Finder _findText(String text) {
    return find.text(text);
  }

  const String errorMessage = 'required at least 1 letter and number 5+ chars';
  const String invalidString = 'password';
  const String validString = 'password123';
  const String regexpattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,}$';
  group('Passwordfield integration test', () {
    testWidgets('passwordfield loads', (WidgetTester tester) async {
      await tester.pumpWidget(_boilerplate(
          child: PasswordField(
        key: const Key('passwordFieldKey'),
      )));
      await tester.pump();
      expect(find.byKey(const Key('passwordFieldKey')), findsOneWidget);
    });

    testWidgets('sets initial text', (WidgetTester tester) async {
      await tester.pumpWidget(_boilerplate(
          child: PasswordField(
        key: const Key('passwordFieldKey'),
        controller: TextEditingController(text: 'password'),
      )));
      await tester.pump();
      expect(find.byKey(const Key('passwordFieldKey')), findsOneWidget);
      expect(_findText('password'), findsOneWidget);
    });

    testWidgets('Widget loads with no error', (WidgetTester tester) async {
      await tester.pumpWidget(_boilerplate(
        child: PasswordField(
          key: const Key('passwordFieldKey'),
          errorMessage: errorMessage,
          pattern: regexpattern,
          inputDecoration: PasswordDecoration(
            inputStyle: const TextStyle(
              fontSize: 14,
            ),
          ),
          hintText: 'Password',
        ),
      ));

      await tester.pumpAndSettle();
      final field = find.byKey(const Key('passwordFieldKey'));
      final errorNotFound = _findText(errorMessage);
      await tester.pump();
      expect(field, findsOneWidget);
      expect(errorNotFound, findsNothing);
    });
  });

  testWidgets('Enter a invalid string throws error',
      (WidgetTester tester) async {
    await tester.pumpWidget(_boilerplate(
      child: PasswordField(
        key: const Key('passwordFieldKey'),
        errorMessage: errorMessage,
        pattern: regexpattern,
        inputDecoration: PasswordDecoration(
          inputStyle: const TextStyle(
            fontSize: 14,
          ),
        ),
        hintText: 'Password',
      ),
    ));

    final field = find.byKey(const Key('passwordFieldKey'));

    await tester.enterText(field, invalidString);
    final invalidText = _findText(invalidString);
    final findsError = _findText(errorMessage);
    await tester.pump();
    expect(invalidText, findsOneWidget);
    expect(findsError, findsOneWidget);
  });

  testWidgets('Valid String hides the error', (WidgetTester tester) async {
    await tester.pumpWidget(_boilerplate(
      child: PasswordField(
        key: const Key('passwordFieldKey'),
        errorMessage: errorMessage,
        pattern: regexpattern,
        inputDecoration: PasswordDecoration(
          inputStyle: const TextStyle(
            fontSize: 14,
          ),
        ),
        hintText: 'Password',
      ),
    ));

    final field = find.byKey(const Key('passwordFieldKey'));
    await tester.enterText(field, validString);
    final validText = _findText(validString);
    final errorFinder = _findText(errorMessage);
    await tester.pump();
    expect(validText, findsOneWidget);
    expect(errorFinder, findsNothing);
  });

  testWidgets('floatingPlaceholder must have a floating text',
      (WidgetTester tester) async {
    Widget passwordWidget() => PasswordField(
          key: const Key('passwordFieldKey'),
          errorMessage: errorMessage,
          pattern: regexpattern,
          inputDecoration: PasswordDecoration(
            inputStyle: const TextStyle(
              fontSize: 14,
            ),
          ),
          hintText: 'Password',
          floatingText: '',
          hasFloatingPlaceholder: true,
        );

    await tester.pump();
    expect(() => passwordWidget(), throwsAssertionError);
  });
}
