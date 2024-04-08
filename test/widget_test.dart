import 'package:flutter/foundation.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager_app/modules/business_logic/login_logic/login_bloc.dart';
import 'package:task_manager_app/modules/business_logic/login_logic/login_events.dart';
import 'package:task_manager_app/modules/business_logic/login_logic/login_states.dart';
import 'package:task_manager_app/modules/view/screens/login_screen.dart';

class MockLoginBloc extends Mock implements LoginBloc {}

void main() {
  group('LoginScreen Widget Tests', () {
    late LoginBloc mockLoginBloc;

    setUp(() {
      mockLoginBloc = MockLoginBloc();
    });

    testWidgets('Initial state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockLoginBloc,
            child: LoginScreen(),
          ),
        ),
      );

      // Test if username and password fields are initially empty.
      expect(find.text(''), findsNWidgets(2));
    });

    testWidgets('Validation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockLoginBloc,
            child: LoginScreen(),
          ),
        ),
      );

      // Test if validator functions work properly.
      await tester.enterText(find.byKey(Key('username_field')), '');
      await tester.enterText(find.byKey(Key('password_field')), '');

      expect(find.text('this field can\'t be empty'), findsNWidgets(2));

      await tester.enterText(find.byKey(Key('username_field')), 'username');
      await tester.enterText(find.byKey(Key('password_field')), 'password');

      expect(find.text('this field can\'t be empty'), findsNothing);
    });

    testWidgets('Login Button Pressed', (WidgetTester tester) async {
      when(mockLoginBloc.state).thenAnswer((_) => LoginInitialState());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockLoginBloc,
            child: LoginScreen(),
          ),
        ),
      );

      await tester.enterText(find.byKey(Key('username_field')), 'username');
      await tester.enterText(find.byKey(Key('password_field')), 'password');

      // Test if login button triggers LoginButtonPressed event with valid input.
      await tester.tap(find.byKey(Key('login_button')));
      verify(mockLoginBloc.add(LoginButtonPressed(
        userName: 'username',
        password: 'password',
      ))).called(1);
    });

    // You can write similar test cases for navigation and error state handling.
  });
}
