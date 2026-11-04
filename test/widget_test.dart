import 'package:africatrip/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home screen shows greeting and destinations', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Good Morning,'), findsOneWidget);
    expect(find.text('Budiarti 👋'), findsOneWidget);
    expect(find.text('Popular Destinations'), findsOneWidget);
    expect(find.text('Lake Pukaki'), findsOneWidget);
  });

  testWidgets('Search field opens the search screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Search here...'));
    await tester.pumpAndSettle();

    expect(find.text('Select Date'), findsOneWidget);
    expect(find.textContaining('Tickets Found'), findsOneWidget);
  });
}
