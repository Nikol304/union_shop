import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/halloween_page.dart';

void main() {
  testWidgets('HalloweenPage navigates to product route',
      (WidgetTester tester) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.window.physicalSizeTestValue = const Size(1200, 800);
    binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      binding.window.clearPhysicalSizeTestValue();
      binding.window.clearDevicePixelRatioTestValue();
    });

    // Provide a dummy /product route so navigation completes quickly
    await tester.pumpWidget(MaterialApp(
      routes: {
        '/product': (context) => const Scaffold(body: Text('Product route')),
      },
      home: const HalloweenPage(),
    ));

    // Allow post-frame navigation to occur
    await tester.pumpAndSettle();

    expect(find.text('Product route'), findsOneWidget);
  });
}
