import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/cart_model.dart';

void main() {
  testWidgets('thumbnail border changes when selected',
      (WidgetTester tester) async {
    final product = Product(
      id: 'p1',
      title: 'T1',
      price: 5.0,
      imageUrl: 'assets/images/hero_1.png',
      galleryImages: ['assets/images/hero_1.png', 'assets/images/hero_11.png'],
      description: 'd',
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

    // Find thumbnail Containers (they have width/height 80 and a BoxDecoration)
    final thumbnailFinder = find.byWidgetPredicate((w) {
      if (w is Container && w.decoration is BoxDecoration) {
        final bd = w.decoration as BoxDecoration;
        if (bd.border != null) return true;
      }
      return false;
    });

    expect(thumbnailFinder, findsWidgets);

    // Inspect first thumbnail border color (selected by default index 0)
    final first = tester.widgetList<Container>(thumbnailFinder).first;
    final firstDec = first.decoration as BoxDecoration;
    final firstBorder = firstDec.border as Border;
    final firstColor = firstBorder.top.color;
    expect(firstColor, isNotNull);

    // Tap second thumbnail and ensure border color changes (selected moves)
    await tester.tap(thumbnailFinder.at(1));
    await tester.pumpAndSettle();

    final afterList = tester.widgetList<Container>(thumbnailFinder).toList();
    final newFirst = afterList[0];
    final newSecond = afterList[1];
    final newFirstColor =
        (newFirst.decoration as BoxDecoration).border!.top.color;
    final newSecondColor =
        (newSecond.decoration as BoxDecoration).border!.top.color;

    expect(newFirstColor != newSecondColor, isTrue);
  });
}
