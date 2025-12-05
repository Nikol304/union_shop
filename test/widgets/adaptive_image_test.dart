import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/adaptive_image.dart';

void main() {
  group('AdaptiveImage widget', () {
    testWidgets('uses AssetImage when path is a local asset', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: AdaptiveImage('assets/images/hero_1.png'),
        ),
      ));

      // The Image widget should be present
      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);

      final Image img = tester.widget<Image>(imageFinder);
      expect(img.image, isA<AssetImage>());
    });

    testWidgets('uses NetworkImage when path starts with http', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: AdaptiveImage('http://example.com/image.png'),
        ),
      ));

      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);

      final Image img = tester.widget<Image>(imageFinder);
      expect(img.image, isA<NetworkImage>());
    });

    testWidgets('shows error fallback when image fails to load',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: AdaptiveImage('http://invalid.example/404.png'),
        ),
      ));

      // Allow image resolution attempts to proceed
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Error builder returns an Icon with broken_image
      expect(find.byIcon(Icons.broken_image), findsWidgets);
    });
  });
}
