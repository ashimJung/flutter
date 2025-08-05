import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assignment1/main.dart';

void main() {
  testWidgets('Weather App basic UI test', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const WeatherApp());

    // Verify input field is present
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Enter city name'), findsOneWidget);

    // Enter a city name
    await tester.enterText(find.byType(TextField), 'Kathmandu');

    // Tap the "Get Weather" button
    await tester.tap(find.text('Get Weather'));

    // Trigger rebuild
    await tester.pump();

    // Check if either result or error/loading indicator shows
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
