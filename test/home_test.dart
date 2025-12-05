import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/widgets/product_card.dart';

void main() {
  group('Home Page Tests', () {
    testWidgets('should display home page with basic elements', (tester) async {
      final binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.window.physicalSizeTestValue = const Size(1200, 800);
      binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(() {
        binding.window.clearPhysicalSizeTestValue();
        binding.window.clearDevicePixelRatioTestValue();
      });

  await tester.pumpWidget(const UnionShopApp(enableHeroAutoSlide: false));
      await tester.pumpAndSettle();

      // Check that key homepage elements are present
      expect(find.text('ESSENTIAL RANGE - OVER 20% OFF!'), findsOneWidget);
      expect(find.byType(ProductCard), findsWidgets);
    });

    testWidgets('should display product cards', (tester) async {
      final binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.window.physicalSizeTestValue = const Size(1200, 800);
      binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(() {
        binding.window.clearPhysicalSizeTestValue();
        binding.window.clearDevicePixelRatioTestValue();
      });

  await tester.pumpWidget(const UnionShopApp(enableHeroAutoSlide: false));
      await tester.pumpAndSettle();

      // ProductCard widgets should be present (at least some products)
      expect(find.byType(ProductCard), findsWidgets);
    });

    testWidgets('should display header icons', (tester) async {
      final binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.window.physicalSizeTestValue = const Size(1200, 800);
      binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(() {
        binding.window.clearPhysicalSizeTestValue();
        binding.window.clearDevicePixelRatioTestValue();
      });

  await tester.pumpWidget(const UnionShopApp(enableHeroAutoSlide: false));
      await tester.pumpAndSettle();

  // Check that header icons commonly present on desktop are visible
  expect(find.byIcon(Icons.search), findsWidgets);
  expect(find.byIcon(Icons.shopping_bag_outlined), findsWidgets);
    });

    testWidgets('should display footer', (tester) async {
      final binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.window.physicalSizeTestValue = const Size(1200, 800);
      binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(() {
        binding.window.clearPhysicalSizeTestValue();
        binding.window.clearDevicePixelRatioTestValue();
      });

  await tester.pumpWidget(const UnionShopApp(enableHeroAutoSlide: false));
      await tester.pumpAndSettle();

      // Footer should contain the opening hours section
      expect(find.text('Opening Hours'), findsOneWidget);
      expect(find.textContaining("We'll never share your email."), findsOneWidget);
    });
  });
}
