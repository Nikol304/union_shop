import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/models/product.dart';

class HalloweenPage extends StatelessWidget {
  const HalloweenPage({super.key});

  static const Product _tote = Product(
    id: 'halloween-tote',
    title: 'Halloween Tote Bags',
    price: 2.50,
    imageUrl: 'assets/halloween/Halloween_bag.png',
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isWide = width > 900;
    final double sidePadding = isWide ? 80 : 20;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sidePadding,
                vertical: 40,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final contentIsWide = constraints.maxWidth > 850;

                  final image = Container(
                    width: contentIsWide
                        ? constraints.maxWidth * 0.45
                        : double.infinity,
                    height: contentIsWide ? 500 : 380,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(_tote.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );

                  final details = SizedBox(
                    width: contentIsWide
                        ? constraints.maxWidth * 0.45
                        : double.infinity,
                    child: _ProductDetails(product: _tote),
                  );

                  return contentIsWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            image,
                            const SizedBox(width: 40),
                            details,
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            image,
                            const SizedBox(height: 30),
                            details,
                          ],
                        );
                },
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final Product product;
  const _ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    const variants = ['Hello Pumpkin', 'Spooky Season', 'Trick or Treat'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          '£${product.price.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Text('Tax included.', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 24),
        const Text('Halloween Tote Bag',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          width: 250,
          child: DropdownButtonFormField(
            value: variants.first,
            items: variants
                .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                .toList(),
            onChanged: (_) {},
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ),
        const SizedBox(height: 20),
        const Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          width: 100,
          child: TextField(
            controller: TextEditingController(text: "1"),
            decoration: const InputDecoration(border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 260,
          height: 48,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF4B2E83)),
            child: const Text('ADD TO CART'),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 260,
          height: 44,
          child: OutlinedButton(
              onPressed: () {}, child: const Text('Buy with shop')),
        ),
        const SizedBox(height: 24),
        const Text(
          'Trick or treat yourself to one of these limited edition Halloween tote bags!',
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 8),
        const Text(
          'Available in store & online for just £2.50!!',
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
      ],
    );
  }
}
