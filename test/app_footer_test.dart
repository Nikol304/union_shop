import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/app_footer.dart';

void main() {
  testWidgets('AppFooter displays key sections', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: const AppFooter(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Check visible headings and subscribe button/text
    // There may be multiple 'Subscribe' widgets in different layout branches,
    // so assert that at least one exists.
    expect(find.text('Subscribe'), findsWidgets);
    expect(find.text('Opening Hours'), findsOneWidget);

    // Copyright with current year
    final year = DateTime.now().year;
    expect(find.text('© $year Union Shop'), findsOneWidget);
  });
}
