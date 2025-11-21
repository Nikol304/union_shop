import 'package:flutter/material.dart';

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
  final bool isMobile = MediaQuery.of(context).size.width < 600;

    // simple dummy “database”
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ============== HEADER (same style) ==============
            Container(
              height: 100,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    color: const Color(0xFF4d2963),
                    child: const Text(
                      'PLACEHOLDER HEADER TEXT',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => navigateToHome(context),
                            child: Image.network(
                              'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                              height: 18,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  width: 18,
                                  height: 18,
                                  child: const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 32),
                          // Nav links (hidden on narrow screens)
                          if (!isMobile)
                            Row(
                              children: [
                                _NavLink(
                                  label: 'Home',
                                  onTap: () => navigateToHome(context),
                                ),
                                _NavLink(
                                  label: 'Products',
                                  onTap: () => navigateToProduct(context),
                                ),
                                _NavLink(
                                  label: 'Collections',
                                  onTap: () => navigateToCollections(context),
                                ),
                                _NavLink(
                                  label: 'Sale',
                                  onTap: () => navigateToSale(context),
                                ),
                                _NavLink(
                                  label: 'About',
                                  onTap: () => navigateToAbout(context),
                                ),
                              ],
                            ),
                          const Spacer(),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.search,
                                      size: 18, color: Colors.grey),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                      minWidth: 32, minHeight: 32),
                                  onPressed: placeholderCallbackForButtons,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.person_outline,
                                      size: 18, color: Colors.grey),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                      minWidth: 32, minHeight: 32),
                                  onPressed: placeholderCallbackForButtons,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.shopping_bag_outlined,
                                      size: 18, color: Colors.grey),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                      minWidth: 32, minHeight: 32),
                                  onPressed: placeholderCallbackForButtons,
                                ),
                                PopupMenuButton<String>(
                                  icon: const Icon(Icons.menu,
                                      size: 18, color: Colors.grey),
                                  onSelected: (value) {
                                    if (value == 'home') {
                                      navigateToHome(context);
                                    } else if (value == 'products') {
                                      navigateToProduct(context);
                                    } else if (value == 'sale') {
                                      navigateToSale(context);
                                    } else if (value == 'collections') {
                                      navigateToCollections(context);
                                    } else if (value == 'about') {
                                      navigateToAbout(context);
                                    }
                                  },
                                  itemBuilder: (context) => const [
                                    PopupMenuItem(value: 'home', child: Text('Home')),
                                    PopupMenuItem(value: 'products', child: Text('Products')),
                                    PopupMenuItem(value: 'sale', child: Text('Sale')),
                                    PopupMenuItem(value: 'collections', child: Text('Collections')),
                                    PopupMenuItem(value: 'about', child: Text('About')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

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
                    'Don’t miss out! Get yours before they’re all gone!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'All prices shown are inclusive of the discount 🛒',
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

            // ============== FOOTER (same style) ==============
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
                  child:
                      Icon(Icons.image_not_supported, color: Colors.grey),
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
        if (product.soldOut)
          const Text(
            'Sold out',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          )
        else if (hasDiscount)
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
            children: [
              const Text('FILTER BY  ', style: labelStyle),
              _FakeDropdown(text: 'All products'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('SORT BY  ', style: labelStyle),
              _FakeDropdown(text: 'Best selling'),
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

    // normal row
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              const Text('FILTER BY  ', style: labelStyle),
              _FakeDropdown(text: 'All products'),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              const Text('SORT BY  ', style: labelStyle),
              _FakeDropdown(text: 'Best selling'),
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
      padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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

class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 13,
          letterSpacing: 1,
          color: Colors.black,
        ),
      ),
    );
  }
}

