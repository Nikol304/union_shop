import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/cart_model.dart';
import 'package:union_shop/widgets/adaptive_image.dart';

class HalloweenPage extends StatefulWidget {
  const HalloweenPage({super.key});

  static const Product product = Product(
    id: 'halloween-tote',
    title: 'Halloween Tote Bags',
    price: 2.50,
    imageUrl: 'assets/images/Halloween_bag.png',
    description:
        'Trick or treat yourself to one of these limited edition Halloween tote bags! '
        'Available online & in-store for just £2.50!',
    galleryImages: const [
      'assets/images/Halloween_bag.png',
      'assets/images/tote_bag.png',
    ],
  );

  @override
  State<HalloweenPage> createState() => _HalloweenPageState();
}

class _HalloweenPageState extends State<HalloweenPage> {
  final List<String> variants = const [
    'Hello Pumpkin',
    'Spooky Season',
    'Trick or Treat'
  ];

  String selectedVariant = 'Hello Pumpkin';
  int quantity = 1;

  void _addToCart() {
    final cart = context.read<CartModel>();

    final personalised = Product(
      id: '${HalloweenPage.product.id}-${selectedVariant.replaceAll(" ", "-")}',
      title: '${HalloweenPage.product.title} - $selectedVariant',
      price: HalloweenPage.product.price,
      imageUrl: HalloweenPage.product.imageUrl,
    );

    cart.addItem(personalised, quantity: quantity);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'Added $quantity × ${HalloweenPage.product.title} — $selectedVariant')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 900;
    final horizontalPadding = isDesktop ? 48.0 : 16.0;
    final verticalPadding = isDesktop ? 32.0 : 16.0;

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth >= 900;

                        final image = _HalloweenImage(
                          imageUrl: HalloweenPage.product.imageUrl,
                        );

                        final details = _HalloweenDetailsPanel(
                          product: HalloweenPage.product,
                          variants: variants,
                          selectedVariant: selectedVariant,
                          quantity: quantity,
                          onVariantChanged: (v) {
                            if (v != null) setState(() => selectedVariant = v);
                          },
                          onQuantityChanged: (value) {
                            if (value > 0) setState(() => quantity = value);
                          },
                          onAddToCart: _addToCart,
                        );

                        return isWide
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(flex: 3, child: image),
                                  const SizedBox(width: 48),
                                  Expanded(flex: 2, child: details),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  image,
                                  const SizedBox(height: 32),
                                  details,
                                ],
                              );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  const AppFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HalloweenImage extends StatelessWidget {
  final String imageUrl;

  const _HalloweenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 480),
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: ClipRRect(
          // increase corner radius so the image looks more rounded
          borderRadius: BorderRadius.circular(24),
          child: AdaptiveImage(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _HalloweenDetailsPanel extends StatelessWidget {
  final Product product;
  final List<String> variants;
  final String selectedVariant;
  final int quantity;
  final ValueChanged<String?> onVariantChanged;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onAddToCart;

  const _HalloweenDetailsPanel({
    required this.product,
    required this.variants,
    required this.selectedVariant,
    required this.quantity,
    required this.onVariantChanged,
    required this.onQuantityChanged,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        Text(
          product.title,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        // Price
        Text(
          '£${product.price.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        const Text('Tax included.', style: TextStyle(color: Colors.grey)),

        const SizedBox(height: 24),

        // Variant picker
        const Text('Design',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          initialValue: selectedVariant,
          items: variants
              .map((v) => DropdownMenuItem(value: v, child: Text(v)))
              .toList(),
          onChanged: onVariantChanged,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), isDense: true),
        ),

        const SizedBox(height: 24),

        // Quantity
        const Text('Quantity',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Row(
          children: [
            IconButton(
              onPressed:
                  quantity > 1 ? () => onQuantityChanged(quantity - 1) : null,
              icon: const Icon(Icons.remove),
            ),
            Text('$quantity'),
            IconButton(
              onPressed: () => onQuantityChanged(quantity + 1),
              icon: const Icon(Icons.add),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Buttons
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onAddToCart,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4B2E83),
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.shade300,
              disabledForegroundColor: Colors.grey.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), // <— pill shape!
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 2,
            ),
            child: const Text('ADD TO CART'),
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            child: const Text('Buy with shop'),
          ),
        ),

        const SizedBox(height: 24),

        // description
        Text(
          product.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
