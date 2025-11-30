import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';

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
    // isMobile handled by AppHeader

    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                        const Expanded(
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
                      const _ProductImages(),
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
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

// ===================== SUB-WIDGETS =====================

class _ProductImages extends StatelessWidget {
  const _ProductImages({Key? key}) : super(key: key);

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
    Key? key,
    required this.selectedColor,
    required this.selectedSize,
    required this.quantity,
    required this.onColorChanged,
    required this.onSizeChanged,
    required this.onQuantityChanged,
  }) : super(key: key);

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
                    initialValue: selectedColor,
                    items: const [
                      DropdownMenuItem(value: 'Black', child: Text('Black')),
                      DropdownMenuItem(value: 'Blue', child: Text('Blue')),
                      DropdownMenuItem(value: 'Grey', child: Text('Grey')),
                    ],
                    onChanged: onColorChanged,
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
                    initialValue: selectedSize,
                    items: const [
                      DropdownMenuItem(value: 'S', child: Text('S')),
                      DropdownMenuItem(value: 'M', child: Text('M')),
                      DropdownMenuItem(value: 'L', child: Text('L')),
                      DropdownMenuItem(value: 'XL', child: Text('XL')),
                    ],
                    onChanged: onSizeChanged,
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

// _NavLink removed; AppHeader now provides navigation links.
