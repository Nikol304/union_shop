import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/home_hero_carousel.dart';

void main() {
  testWidgets('HomeHeroCarousel shows first slide title',
      (WidgetTester tester) async {
    // Pump the widget inside a MaterialApp to provide Navigator and theme
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: HomeHeroCarousel(),
      ),
    ));

    // Allow animations/frame callbacks to run
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // The first slide's title should be present
    expect(find.text('Essential Range – Over 20% OFF!'), findsOneWidget);

    // The CTA button for the first slide should be present
    expect(find.text('BROWSE COLLECTION'), findsOneWidget);
  });
}
