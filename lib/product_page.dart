import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String _selectedColor = 'Black';
  String _selectedSize = 'S';
  String _quantity = '1';

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void navigateToCollections(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  void navigateToSale(BuildContext context) {
    Navigator.pushNamed(context, '/sale');
  }

  void navigateToSimilar(BuildContext context) {
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              height: 100,
              color: Colors.white,
              child: Column(
                children: [
                  // Top banner
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
                  // Main header with nav links
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          // Logo -> Home
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
                                    child: Icon(Icons.image_not_supported,
                                        color: Colors.grey),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 32),

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
                                onTap: () => navigateToSimilar(context),
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
                                  icon: const Icon(
                                    Icons.search,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: placeholderCallbackForButtons,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.person_outline,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: placeholderCallbackForButtons,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: placeholderCallbackForButtons,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.menu,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: placeholderCallbackForButtons,
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

            // ============== PRODUCT CONTENT ==============
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 40,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bool isWide = constraints.maxWidth > 900;

                  if (isWide) {
                    // Desktop-ish: two columns
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LEFT: main image + thumbnails
                        Expanded(
                          flex: 5,
                          child: _ProductImages(),
                        ),
                        const SizedBox(width: 48),
                        // RIGHT: details
                        Expanded(
                          flex: 5,
                          child: _ProductDetailsPanel(
                            selectedColor: _selectedColor,
                            onColorChanged: (value) {
                              if (value != null) {
                                setState(() => _selectedColor = value);
                              }
                            },
                            selectedSize: _selectedSize,
                            onSizeChanged: (value) {
                              if (value != null) {
                                setState(() => _selectedSize = value);
                              }
                            },
                            quantity: _quantity,
                            onQuantityChanged: (value) {
                              setState(() => _quantity = value);
                            },
                          ),
                        ),
                      ],
                    );
                  }

                  // Mobile / tablet: stacked
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ProductImages(),
                      const SizedBox(height: 32),
                      _ProductDetailsPanel(
                        selectedColor: _selectedColor,
                        onColorChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedColor = value);
                          }
                        },
                        selectedSize: _selectedSize,
                        onSizeChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedSize = value);
                          }
                        },
                        quantity: _quantity,
                        onQuantityChanged: (value) {
                          setState(() => _quantity = value);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),

            // ================= FOOTER =================
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
                                border: OutlineInputBorder(),
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
                                          border: OutlineInputBorder(),
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

// ===================== SUB-WIDGETS =====================

class _ProductImages extends StatelessWidget {
  _ProductImages({super.key});

  final String mainImageUrl =
      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854'; // replace with real hoodie image
  final List<String> thumbnails = const [
    'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
    'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
    'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
    'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 4 / 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              mainImageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.image_not_supported,
                        size: 48, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 90,
          child: Row(
            children: thumbnails
                .map(
                  (url) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: AspectRatio(
                        aspectRatio: 4 / 3,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _ProductDetailsPanel extends StatelessWidget {
  final String selectedColor;
  final String selectedSize;
  final String quantity;
  final ValueChanged<String?> onColorChanged;
  final ValueChanged<String?> onSizeChanged;
  final ValueChanged<String> onQuantityChanged;

  const _ProductDetailsPanel({
    super.key,
    required this.selectedColor,
    required this.selectedSize,
    required this.quantity,
    required this.onColorChanged,
    required this.onSizeChanged,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF4d2963);
    const shopPurple = Color(0xFF5a31f4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Classic Sweatshirts',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          '£23.00',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Tax included.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 24),

        // Color + Size
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Color'),
                  const SizedBox(height: 4),
                  DropdownButtonFormField<String>(
                    value: selectedColor,
                    items: const [
                      DropdownMenuItem(value: 'Black', child: Text('Black')),
                      DropdownMenuItem(value: 'Green', child: Text('Green')),
                      DropdownMenuItem(value: 'Purple', child: Text('Purple')),
                    ],
                    onChanged: onColorChanged,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Size'),
                  const SizedBox(height: 4),
                  DropdownButtonFormField<String>(
                    value: selectedSize,
                    items: const [
                      DropdownMenuItem(value: 'S', child: Text('S')),
                      DropdownMenuItem(value: 'M', child: Text('M')),
                      DropdownMenuItem(value: 'L', child: Text('L')),
                      DropdownMenuItem(value: 'XL', child: Text('XL')),
                    ],
                    onChanged: onSizeChanged,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Quantity
        Row(
          children: [
            const Text('Quantity'),
            const SizedBox(width: 16),
            SizedBox(
              width: 80,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: quantity),
                onChanged: onQuantityChanged,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // ADD TO CART button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: purple,
              side: const BorderSide(color: purple),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text(
              'ADD TO CART',
              style: TextStyle(
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Buy with shop button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: shopPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text(
              'Buy with shop',
              style: TextStyle(
                letterSpacing: 1.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        TextButton(
          onPressed: () {},
          child: const Text(
            'More payment options',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ),
        const SizedBox(height: 24),

        const Text(
          'Bringing to you, our best selling Classic Sweatshirt. '
          'Available in 4 different colours.',
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
          ),
        ),
      ],
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
