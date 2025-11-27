import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  // ===== NAV HELPERS =====
  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void navigateToCollections(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  void navigateToSale(BuildContext context) {
    Navigator.pushNamed(context, '/sale');
  }

  void navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void placeholderCallbackForButtons() {
    // placeholder
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 1100 ? 120 : (screenWidth > 800 ? 64 : 24);

    // simple dummy database
    final saleProducts = <_SaleProduct>[
      _SaleProduct(
        title: 'A5 Notepad',
        imageUrl:
            'https://images.pexels.com/photos/950241/pexels-photo-950241.jpeg',
        oldPrice: '£3.00',
        price: '£1.80',
        soldOut: true,
      ),
      _SaleProduct(
        title: 'Classic Sweatshirts - Neutral',
        imageUrl:
            'https://images.pexels.com/photos/7671166/pexels-photo-7671166.jpeg',
        oldPrice: '£17.00',
        price: '£10.99',
      ),
      _SaleProduct(
        title: 'Recycled Notebook',
        imageUrl:
            'https://images.pexels.com/photos/3831849/pexels-photo-3831849.jpeg',
        price: '£1.80',
      ),
      _SaleProduct(
        title: 'iPhone Charge & Sync Cable',
        imageUrl:
            'https://images.pexels.com/photos/1054389/pexels-photo-1054389.jpeg',
        oldPrice: '£3.00',
        price: '£1.50',
      ),
      _SaleProduct(
        title: 'Dimple Pop Fidget Keyring',
        imageUrl:
            'https://images.pexels.com/photos/3662718/pexels-photo-3662718.jpeg',
        oldPrice: '£1.50',
        price: '£0.99',
      ),
      _SaleProduct(
        title: 'Nike Academy 18 Tech Pants (W)',
        imageUrl:
            'https://images.pexels.com/photos/7671173/pexels-photo-7671173.jpeg',
        oldPrice: '£24.99',
        price: '£7.00',
      ),
      _SaleProduct(
        title: 'Nike Academy 18 Tech Pants (M)',
        imageUrl:
            'https://images.pexels.com/photos/7671168/pexels-photo-7671168.jpeg',
        price: 'Sold out',
        soldOut: true,
      ),
    ];

    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ============== SALE CONTENT ==============
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'SALE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Don't miss out! Get yours before they're all gone!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'All prices shown are inclusive of the discount',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 40),

                  // ---- Filter / Sort Bar ----
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isNarrow = constraints.maxWidth < 700;

                      if (isNarrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _FilterSortRow(
                              productsCount: '${saleProducts.length} products',
                              compact: true,
                            ),
                            const SizedBox(height: 24),
                          ],
                        );
                      }

                      return Column(
                        children: [
                          _FilterSortRow(
                            productsCount: '${saleProducts.length} products',
                            compact: false,
                          ),
                          const SizedBox(height: 32),
                        ],
                      );
                    },
                  ),

                  // ---- Product grid ----
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int columns = 1;
                      if (constraints.maxWidth >= 1100) {
                        columns = 3;
                      } else if (constraints.maxWidth >= 750) {
                        columns = 2;
                      }

                      final double spacing = 32;
                      final double cardWidth =
                          (constraints.maxWidth - spacing * (columns - 1)) /
                              columns;

                      return Wrap(
                        spacing: spacing,
                        runSpacing: 48,
                        children: saleProducts
                            .map(
                              (p) => SizedBox(
                                width: cardWidth,
                                child: _SaleProductCard(product: p),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // ---- Pagination ----
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          side: const BorderSide(color: Colors.black12),
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 24),
                      const Text('Page 1 of 2'),
                      const SizedBox(width: 24),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          side: const BorderSide(color: Colors.black12),
                        ),
                        child: const Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Shared footer
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

// ===== Models & small widgets =====

class _SaleProduct {
  final String title;
  final String imageUrl;
  final String? oldPrice;
  final String price;
  final bool soldOut;

  _SaleProduct({
    required this.title,
    required this.imageUrl,
    this.oldPrice,
    this.price = '',
    this.soldOut = false,
  });
}

class _SaleProductCard extends StatelessWidget {
  final _SaleProduct product;

  const _SaleProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final bool hasDiscount =
        product.oldPrice != null && !product.soldOut && product.oldPrice != '';

    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[200],
                child: const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (hasDiscount)
                      Text(product.oldPrice ?? '',
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey)),
                    if (hasDiscount) const SizedBox(width: 8),
                    Text(product.price,
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                    onPressed: () {}, child: const Text('Add to basket')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterSortRow extends StatelessWidget {
  final String productsCount;
  final bool compact;

  const _FilterSortRow({required this.productsCount, required this.compact});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(productsCount),
        Row(
          children: [
            const Text('Sort by'),
            const SizedBox(width: 8),
            DropdownButton<String>(items: const [
              DropdownMenuItem(value: 'pop', child: Text('Popularity'))
            ], onChanged: (_) {}),
          ],
        ),
      ],
    );
  }
}
