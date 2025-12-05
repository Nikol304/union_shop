import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/app_footer.dart';

void main() {
  testWidgets('AppFooter shows sections and subscribe button',
      (WidgetTester tester) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.window.physicalSizeTestValue = const Size(1200, 800);
    binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      binding.window.clearPhysicalSizeTestValue();
      binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: AppFooter())));
    await tester.pumpAndSettle();

  expect(find.text('Opening Hours'), findsOneWidget);
  expect(find.text('Help'), findsOneWidget);
  // 'Subscribe' appears more than once in the widget tree (wide vs narrow
  // variants). Assert at least one occurrence.
  expect(find.text('Subscribe'), findsWidgets);
  expect(find.textContaining("We'll never share your email."), findsOneWidget);
  });
}
