import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';

class MerchPage extends StatelessWidget {
  const MerchPage({super.key});

  // ---------- NAV HELPERS ----------
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
    // placeholder for now
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 1100 ? 120 : (screenWidth > 800 ? 64 : 24);

    // Dummy merchandise items – replace with real data later
    final List<_MerchProduct> merchProducts = [
      _MerchProduct(
        title: 'Union Tote Bag',
        imageUrl:
            'https://images.pexels.com/photos/1002638/pexels-photo-1002638.jpeg',
        price: '£8.00',
      ),
      _MerchProduct(
        title: 'Union Mug',
        imageUrl:
            'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg',
        price: '£6.00',
      ),
      _MerchProduct(
        title: 'Union Sticker Pack',
        imageUrl:
            'https://images.pexels.com/photos/208119/pexels-photo-208119.jpeg',
        price: '£3.00',
      ),
      _MerchProduct(
        title: 'Union Badge Set',
        imageUrl:
            'https://images.pexels.com/photos/7608496/pexels-photo-7608496.jpeg',
        price: '£4.50',
      ),
    ];

    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ============== MERCH CONTENT ==============
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
                    'Merchandise',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Product grid
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int columns = 1;
                      if (constraints.maxWidth >= 1100) {
                        columns = 3;
                      } else if (constraints.maxWidth >= 750) {
                        columns = 2;
                      }

                      const double spacing = 32;
                      final double cardWidth =
                          (constraints.maxWidth - spacing * (columns - 1)) /
                              columns;

                      return Wrap(
                        spacing: spacing,
                        runSpacing: 48,
                        children: merchProducts
                            .map(
                              (p) => SizedBox(
                                width: cardWidth,
                                child: _MerchProductCard(product: p),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // Pagination
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
                      const Text('Page 1 of 1'),
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

// ===== MODELS & SMALL WIDGETS =====

class _MerchProduct {
  final String title;
  final String imageUrl;
  final String? oldPrice;
  final String price;

  _MerchProduct({
    required this.title,
    required this.imageUrl,
    this.oldPrice,
    required this.price,
  });
}

class _MerchProductCard extends StatelessWidget {
  final _MerchProduct product;

  const _MerchProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final bool hasDiscount =
        product.oldPrice != null && product.oldPrice!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 4 / 3,
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: const Center(
                  child: Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Text(
          product.title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        if (hasDiscount)
          Row(
            children: [
              Text(
                product.oldPrice!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                product.price,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        else
          Text(
            product.price,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}

// _FakeDropdown is defined in other pages where needed; not used in this file.

// _NavLink removed; AppHeader centralizes navigation.
