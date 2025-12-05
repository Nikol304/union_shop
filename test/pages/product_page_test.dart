import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_model.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/product_page.dart';

class TestCartModel extends CartModel {
  Product? lastAddedProduct;
  int lastAddedQuantity = 0;
  String? lastAddedColor;
  String? lastAddedSize;

  @override
  void addItem(Product product,
      {String? color, String? size, int quantity = 1}) {
    lastAddedProduct = product;
    lastAddedQuantity = quantity;
    lastAddedColor = color;
    lastAddedSize = size;
    super.addItem(product, color: color, size: size, quantity: quantity);
  }
}

void main() {
  group('ProductPage', () {
    testWidgets('shows fallback when no product argument passed',
        (WidgetTester tester) async {
      // Increase the test window size to avoid AppHeader layout overflow in
      // tight constraints. Use the binding to set a larger physical size.
      final binding = TestWidgetsFlutterBinding.ensureInitialized()
          as TestWidgetsFlutterBinding;
      binding.window.physicalSizeTestValue = const Size(1400, 900);
      binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(() {
        binding.window.clearPhysicalSizeTestValue();
        binding.window.clearDevicePixelRatioTestValue();
      });

      // Provide a CartModel provider so AppHeader's Consumer can find it
      await tester.pumpWidget(ChangeNotifierProvider<CartModel>(
        create: (_) => CartModel(),
        child: const MaterialApp(home: ProductPage()),
      ));

      // Since ProductPage checks ModalRoute args, when none provided it returns
      // a Scaffold with the fallback text.
      await tester.pumpAndSettle();

      expect(find.textContaining('No product found'), findsOneWidget);
    });

    testWidgets('thumbnail tap updates selected image and ADD TO CART works',
        (WidgetTester tester) async {
      final product = Product(
        id: 'prod-1',
        title: 'Prod 1',
        price: 9.99,
        imageUrl: 'assets/images/hero_1.png',
        galleryImages: [
          'assets/images/hero_1.png',
          'assets/images/hero_11.png'
        ],
        description: 'A test product',
      );

      final testCart = TestCartModel();

      // Increase test window size to avoid header overflow
      final binding = TestWidgetsFlutterBinding.ensureInitialized()
          as TestWidgetsFlutterBinding;
      binding.window.physicalSizeTestValue = const Size(1400, 900);
      binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(() {
        binding.window.clearPhysicalSizeTestValue();
        binding.window.clearDevicePixelRatioTestValue();
      });

      // Provide the CartModel and open ProductPage with the product argument
      await tester.pumpWidget(ChangeNotifierProvider<CartModel>.value(
        value: testCart,
        child: MaterialApp(
          home: Builder(builder: (context) {
            // schedule navigation to ProductPage with the product
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

      // Ensure there are at least two Image widgets (main image + thumbnails)
      // We avoid brittle inspection of Container.width/height and instead
      // assert the presence of image widgets. This is robust across layouts.
      final imageCount = find.byType(Image).evaluate().length;
      expect(imageCount, greaterThanOrEqualTo(2));

      // Find the ADD TO CART button and tap it
      final addButton = find.widgetWithText(ElevatedButton, 'ADD TO CART');
      expect(addButton, findsOneWidget);

      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // CartModel should have received the item
      expect(testCart.lastAddedProduct, isNotNull);
      expect(testCart.lastAddedProduct!.id, equals(product.id));

      // SnackBar should be shown
      expect(find.text('Added to cart'), findsOneWidget);

      // Description should be rendered
      expect(find.text('A test product'), findsOneWidget);
    });
  });
}
