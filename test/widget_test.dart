import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_03/main.dart';

void main() {
  testWidgets('Rajang Cruise App renders and dynamic star rating updates',
      (WidgetTester tester) async {
    await tester.pumpWidget(const RajangCruiseApp());
    await tester.pumpAndSettle();

    // Verify Title and Subtitle are displayed
    expect(find.text('Rajang River Express Cruise'), findsOneWidget);
    expect(find.text('Sibu Waterfront, Sarawak'), findsOneWidget);

    // Verify Initial Rating starts at 42
    expect(find.text('42'), findsOneWidget);

    // Tap the star button to favorite / increment
    await tester.tap(find.byIcon(Icons.star_border));
    await tester.pumpAndSettle();

    // Verify rating incremented to 43 and star icon is now filled
    expect(find.text('43'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget);

    // Verify Action Bar buttons exist
    expect(find.text('CALL'), findsOneWidget);
    expect(find.text('ROUTE'), findsOneWidget);
    expect(find.text('SHARE'), findsOneWidget);

    // Verify Preferences are present
    expect(find.text('Trip Preferences'), findsOneWidget);
  });
}
