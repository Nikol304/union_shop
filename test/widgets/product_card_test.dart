import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/product_card.dart';

class TestNavigatorObserver extends NavigatorObserver {
  Route? pushedRoute;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    pushedRoute = route;
  }
}

void main() {
  group('ProductCard widget', () {
    testWidgets('renders title, price and image; navigates on tap',
        (WidgetTester tester) async {
      final product = const Product(
        id: 'p-1',
        title: 'Test Product',
        price: 12.0,
        imageUrl: 'assets/images/hero_1.png',
      );

      final observer = TestNavigatorObserver();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 280,
              child: ProductCard(product: product),
            ),
          ),
        ),
        navigatorObservers: [observer],
        // Ensure route exists so pushNamed succeeds
        routes: {
          '/product': (context) => const Scaffold(body: Text('ProductPage')),
        },
      ));

      await tester.pumpAndSettle();

      // Title and price present
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('£12.00'), findsOneWidget);

      // Image widget present (AdaptiveImage uses Image internally)
      expect(find.byType(Image), findsOneWidget);

      // Tap the card
      await tester.tap(find.byType(ProductCard));
      await tester.pumpAndSettle();

      // Navigator push should have occurred to /product
      expect(observer.pushedRoute, isNotNull);
      expect(observer.pushedRoute!.settings.name, '/product');

      // The route arguments should be the same product instance
      expect(observer.pushedRoute!.settings.arguments, equals(product));
    });
  });
}
