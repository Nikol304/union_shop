import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/home_hero_carousel.dart';

void main() {
  testWidgets('HomeHeroCarousel shows slides and responds to swipe',
      (WidgetTester tester) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.window.physicalSizeTestValue = const Size(1200, 800);
    binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      binding.window.clearPhysicalSizeTestValue();
      binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: HomeHeroCarousel(enableAutoSlide: false))));
    await tester.pumpAndSettle();

    // Initial slide contains title text from slides[0]
    expect(find.text('Essential Range – Over 20% OFF!'), findsOneWidget);

    // Perform a horizontal drag to move to next slide
    await tester.fling(find.byType(PageView), const Offset(-300, 0), 1000);
    await tester.pumpAndSettle(const Duration(milliseconds: 700));

    // Now the second slide title should be visible
    expect(find.textContaining('New Merch Drop'), findsOneWidget);
  });
}
