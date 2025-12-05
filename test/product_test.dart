import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/cart_model.dart';

void main() {
  group('Product Page Tests', () {
    testWidgets('shows fallback when no product argument passed',
        (WidgetTester tester) async {
      final binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.window.physicalSizeTestValue = const Size(1200, 800);
      binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(() {
        binding.window.clearPhysicalSizeTestValue();
        binding.window.clearDevicePixelRatioTestValue();
      });

      await tester.pumpWidget(ChangeNotifierProvider<CartModel>(
        create: (_) => CartModel(),
        child: const MaterialApp(home: ProductPage()),
      ));

      await tester.pumpAndSettle();

      expect(find.textContaining('No product found'), findsOneWidget);
    });

    testWidgets('renders product details and add to cart',
        (WidgetTester tester) async {
      final product = Product(
        id: 'prod-1',
        title: 'Prod 1',
        price: 9.99,
        imageUrl: 'assets/images/hero_1.png',
        galleryImages: ['assets/images/hero_1.png'],
        description: 'A test product',
      );

      final binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.window.physicalSizeTestValue = const Size(1200, 800);
      binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(() {
        binding.window.clearPhysicalSizeTestValue();
        binding.window.clearDevicePixelRatioTestValue();
      });

      await tester.pumpWidget(ChangeNotifierProvider<CartModel>.value(
        value: CartModel(),
        child: MaterialApp(
          home: Builder(builder: (context) {
            Future.microtask(() {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const ProductPage(),
                settings: RouteSettings(arguments: product),
              ));
            });
            return const Scaffold();
          }),
        ),
      ));

      await tester.pumpAndSettle();

      expect(find.text('Prod 1'), findsOneWidget);
      expect(find.text('A test product'), findsOneWidget);
      expect(find.textContaining('£'), findsOneWidget);
      expect(find.text('ADD TO CART'), findsOneWidget);
    });
  });
}
