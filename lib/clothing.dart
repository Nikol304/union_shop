import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';

class ClothingPage extends StatelessWidget {
  const ClothingPage({super.key});

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

    // Dummy clothing products – replace with real data later
    final List<_ClothingProduct> clothingProducts = [
      _ClothingProduct(
        title: 'Classic Hoodies',
        imageUrl:
            'https://images.pexels.com/photos/7671166/pexels-photo-7671166.jpeg',
        price: '£25.00',
      ),
      _ClothingProduct(
        title: 'Classic Sweatshirts',
        imageUrl:
            'https://images.pexels.com/photos/7671173/pexels-photo-7671173.jpeg',
        price: '£23.00',
      ),
      _ClothingProduct(
        title: 'Classic T-Shirts',
        imageUrl:
            'https://images.pexels.com/photos/7697491/pexels-photo-7697491.jpeg',
        price: '£11.00',
      ),
      _ClothingProduct(
        title: 'Classic Sweatshirts - Neutral',
        imageUrl:
            'https://images.pexels.com/photos/7671170/pexels-photo-7671170.jpeg',
        oldPrice: '£17.00',
        price: '£10.99',
      ),
      _ClothingProduct(
        title: 'Graduation Hoodies',
        imageUrl:
            'https://images.pexels.com/photos/7671168/pexels-photo-7671168.jpeg',
        price: '£35.00',
      ),
      _ClothingProduct(
        title: 'Graduation 3/4 Zipped Sweatshirt',
        imageUrl:
            'https://images.pexels.com/photos/7671171/pexels-photo-7671171.jpeg',
        price: '£45.00',
      ),
      _ClothingProduct(
        title: 'Classic Cap',
        imageUrl:
            'https://images.pexels.com/photos/1166413/pexels-photo-1166413.jpeg',
        price: '£12.00',
      ),
      _ClothingProduct(
        title: 'Classic Beanie Hat',
        imageUrl:
            'https://images.pexels.com/photos/7671174/pexels-photo-7671174.jpeg',
        price: '£12.00',
      ),
      _ClothingProduct(
        title: 'Classic Rainbow Hoodies',
        imageUrl:
            'https://images.pexels.com/photos/7671169/pexels-photo-7671169.jpeg',
        oldPrice: '£30.00',
        price: '£12.99',
      ),
    ];

    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ============== CLOTHING CONTENT ==============
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
                    'Clothing',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Filter / Sort row
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isNarrow = constraints.maxWidth < 700;

                      if (isNarrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _FilterSortRow(
                              productsCount:
                                  '${clothingProducts.length} products',
                              compact: true,
                            ),
                            const SizedBox(height: 24),
                          ],
                        );
                      }

                      return Column(
                        children: [
                          _FilterSortRow(
                            productsCount:
                                '${clothingProducts.length} products',
                            compact: false,
                          ),
                          const SizedBox(height: 32),
                        ],
                      );
                    },
                  ),

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
                        children: clothingProducts
                            .map(
                              (p) => SizedBox(
                                width: cardWidth,
                                child: _ClothingProductCard(product: p),
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

            // ============== FOOTER (same as other pages) ==============
            Container(
              width: double.infinity,
              color: Colors.grey[50],
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 600;
                      if (isNarrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Opening Hours',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('Mon - Fri: 09:00 - 17:00'),
                            const Text('Sat: 10:00 - 16:00'),
                            const Text('Sun: Closed'),
                            const SizedBox(height: 16),
                            const Text(
                              'Help',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: placeholderCallbackForButtons,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft,
                              ),
                              child: const Text('Contact Us'),
                            ),
                            TextButton(
                              onPressed: placeholderCallbackForButtons,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft,
                              ),
                              child: const Text('Shipping & Returns'),
                            ),
                            TextButton(
                              onPressed: placeholderCallbackForButtons,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft,
                              ),
                              child: const Text('Privacy Policy'),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Subscribe',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                border: const OutlineInputBorder(),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: placeholderCallbackForButtons,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4d2963),
                                ),
                                child: const Text('Subscribe'),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "We\'ll never share your email.",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Opening Hours',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text('Mon - Fri: 09:00 - 17:00'),
                                Text('Sat: 10:00 - 16:00'),
                                Text('Sun: Closed'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Help',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextButton(
                                  onPressed: placeholderCallbackForButtons,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  child: const Text('Contact Us'),
                                ),
                                TextButton(
                                  onPressed: placeholderCallbackForButtons,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  child: const Text('Shipping & Returns'),
                                ),
                                TextButton(
                                  onPressed: placeholderCallbackForButtons,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  child: const Text('Privacy Policy'),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Subscribe',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Enter your email',
                                          border: const OutlineInputBorder(),
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: placeholderCallbackForButtons,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF4d2963),
                                      ),
                                      child: const Text('Subscribe'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "We\'ll never share your email.",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      '© ${DateTime.now().year} Union Shop',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== MODELS & SMALL WIDGETS =====

class _ClothingProduct {
  final String title;
  final String imageUrl;
  final String? oldPrice;
  final String price;

  _ClothingProduct({
    required this.title,
    required this.imageUrl,
    this.oldPrice,
    required this.price,
  });
}

class _ClothingProductCard extends StatelessWidget {
  final _ClothingProduct product;

  const _ClothingProductCard({required this.product});

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

class _FilterSortRow extends StatelessWidget {
  final String productsCount;
  final bool compact;

  const _FilterSortRow({
    required this.productsCount,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    const labelStyle =
        TextStyle(fontSize: 12, letterSpacing: 1, color: Colors.black54);

    if (compact) {
      // stacked for mobile
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text('FILTER BY  ', style: labelStyle),
              _FakeDropdown(text: 'All products'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Text('SORT BY  ', style: labelStyle),
              _FakeDropdown(text: 'Featured'),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            productsCount,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      );
    }

    // desktop-ish row
    return Row(
      children: [
        Expanded(
          child: Row(
            children: const [
              Text('FILTER BY  ', style: labelStyle),
              _FakeDropdown(text: 'All products'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: const [
              Text('SORT BY  ', style: labelStyle),
              _FakeDropdown(text: 'Featured'),
            ],
          ),
        ),
        Text(
          productsCount,
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
      ],
    );
  }
}

class _FakeDropdown extends StatelessWidget {
  final String text;
  const _FakeDropdown({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          const SizedBox(width: 4),
          const Icon(Icons.expand_more, size: 18),
        ],
      ),
    );
  }
}

// _NavLink removed; AppHeader provides navigation links.
