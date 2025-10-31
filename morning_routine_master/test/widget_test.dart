// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:morning_routine_master/main2.dart';
// import 'package:table_calendar/table_calendar.dart';

void main() {
  testWidgets('Morning Routine Master UI smoke test', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MorningRoutineApp());

    // Check that the app loaded HomeScreen
    expect(find.text('Morning Routine Master\nBuild lasting morning habits 🌅'), findsOneWidget);

    // Verify that bottom navigation has all items
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Routine'), findsOneWidget);
    expect(find.text('Stats'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    // Tap on Routine tab and verify Routine screen loads
    await tester.tap(find.text('Routine'));
    await tester.pumpAndSettle();

    expect(find.text('Morning Routine Master\nBuild lasting morning habits ☀️'), findsOneWidget);
    expect(find.text('Add Task'), findsOneWidget);

    // Tap on Settings tab and verify Settings screen loads
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Morning Start Time'), findsOneWidget);
    expect(find.text('Daily Reminders'), findsOneWidget);

    // Tap on Home again and verify HomeScreen appears
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Morning rituals create extraordinary days'), findsOneWidget);

    // Scroll test: ensure ListView scrolls without issues
    await tester.fling(find.byType(ListView), const Offset(0, -300), 1000);
    await tester.pump();

    // Verify progress bar exists
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });
}
