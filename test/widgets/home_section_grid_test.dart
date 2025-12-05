import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/product_card.dart';

// Local test-only widget that mirrors the home section grid logic
class TestHomeSection extends StatelessWidget {
  final String title;
  final List<Product> products;

  const TestHomeSection(
      {super.key, required this.title, required this.products});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              Text(title),
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool wide = constraints.maxWidth >= 900;
                  final int crossAxisCount = wide ? 2 : 1;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: wide ? 1.0 : 0.8,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  group('Home section grid layout', () {
    final products = List.generate(
      4,
      (i) => Product(
        id: 'p$i',
        title: 'Product $i',
        price: 10.0 + i,
        imageUrl: 'assets/images/hero_1.png',
      ),
    );

    testWidgets('grid shows all products passed', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: SizedBox(
                width: 800,
                child: TestHomeSection(title: 'Test', products: products))),
      ));

      await tester.pumpAndSettle();

      expect(find.byType(ProductCard), findsNWidgets(products.length));
    });

    testWidgets('grid renders correctly for multiple widths without throwing',
        (tester) async {
      // Narrow layout -> single column expected, but we assert rendering stability
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(size: Size(600, 800)),
        child: MaterialApp(
          home: Scaffold(
              body: SizedBox(
                  width: 600,
                  child: TestHomeSection(title: 'Test', products: products))),
        ),
      ));

      await tester.pumpAndSettle();
      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(ProductCard), findsNWidgets(products.length));

      // Wide layout -> stable rendering
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(size: Size(1200, 1000)),
        child: MaterialApp(
          home: Scaffold(
              body: SizedBox(
                  width: 1000,
                  child: TestHomeSection(title: 'Test', products: products))),
        ),
      ));

      await tester.pumpAndSettle();
      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(ProductCard), findsNWidgets(products.length));
    });
  });
}
