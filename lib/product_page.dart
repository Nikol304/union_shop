import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_model.dart';
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
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;
    final horizontalPadding = isDesktop ? 48.0 : 16.0;
    final verticalPadding = isDesktop ? 32.0 : 16.0;

    return Scaffold(
      body: Column(
        children: [
          // 👇 stays fixed at the top
          const AppHeader(),

          // 👇 everything below scrolls (product layout + footer)
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

                        final image = _ProductImage(imageUrl: product.imageUrl);

                        final details = _ProductDetailsPanel(
                          product: product,
                          selectedColor: _selectedColor,
                          selectedSize: _selectedSize,
                          quantity: _quantity,
                          onColorChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedColor = value);
                            }
                          },
                          onSizeChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedSize = value);
                            }
                          },
                          onQuantityChanged: (value) {
                            setState(() => _quantity = value);
                          },
                        );

                        // Desktop: image left, details right
                        if (isWide) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 3, child: image),
                              const SizedBox(width: 48),
                              Expanded(flex: 2, child: details),
                            ],
                          );
                        }

                        // Mobile / tablet: stacked
                        return Column(
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
                  const AppFooter(), // 👈 footer scrolls into view
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String imageUrl;

  const _ProductImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      // cap the visual height so the image isn’t gigantic
      constraints: const BoxConstraints(maxHeight: 480),
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Builder(builder: (context) {
            final bool isNetwork = imageUrl.startsWith('http');

            final Widget image = isNetwork
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child:
                            Icon(Icons.image_not_supported, color: Colors.grey),
                      ),
                    ),
                  )
                : Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child:
                            Icon(Icons.image_not_supported, color: Colors.grey),
                      ),
                    ),
                  );

            return image;
          }),
        ),
      ),
    );
  }
}

class _ProductDetailsPanel extends StatelessWidget {
  final Product product;
  final String selectedColor;
  final String selectedSize;
  final int quantity;
  final ValueChanged<String?> onColorChanged;
  final ValueChanged<String?> onSizeChanged;
  final ValueChanged<int> onQuantityChanged;

  const _ProductDetailsPanel({
    required this.product,
    required this.selectedColor,
    required this.selectedSize,
    required this.quantity,
    required this.onColorChanged,
    required this.onSizeChanged,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final priceText = '£${product.price.toStringAsFixed(2)}';
    final oldPriceText = product.oldPrice != null
        ? '£${product.oldPrice!.toStringAsFixed(2)}'
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          product.title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        // Price + old price
        Row(
          children: [
            Text(
              priceText,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            if (oldPriceText != null)
              Text(
                oldPriceText,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
              ),
          ],
        ),
        const SizedBox(height: 16),

        // Color
        const Text(
          'Color',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: selectedColor,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
          ),
          items: const [
            DropdownMenuItem(value: 'Black', child: Text('Black')),
            DropdownMenuItem(value: 'Grey', child: Text('Grey')),
            DropdownMenuItem(value: 'Purple', child: Text('Purple')),
          ],
          onChanged: onColorChanged,
        ),
        const SizedBox(height: 16),

        // Size
        const Text(
          'Size',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: selectedSize,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
          ),
          items: const [
            DropdownMenuItem(value: 'S', child: Text('S')),
            DropdownMenuItem(value: 'M', child: Text('M')),
            DropdownMenuItem(value: 'L', child: Text('L')),
          ],
          onChanged: onSizeChanged,
        ),
        const SizedBox(height: 16),

        // Quantity
        const Text(
          'Quantity',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
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
            onPressed: () {
              if (quantity <= 0) return;
              final cart = context.read<CartModel>();
              cart.addItem(
                product,
                color: selectedColor,
                size: selectedSize,
                quantity: quantity,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to cart')),
              );
            },
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

        // Description
        if (product.description.isNotEmpty)
          Text(
            product.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
      ],
    );
  }
}
