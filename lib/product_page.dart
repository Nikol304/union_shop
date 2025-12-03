import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/adaptive_image.dart';
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

  // for gallery-style main image + thumbnails
  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is! Product) {
      // show helpful fallback instead of crashing
      return Scaffold(
        appBar: const AppHeader(),
        body: const Center(
          child: Text(
            'No product found.\nMake sure you pass a Product as navigation argument.',
            textAlign: TextAlign.center,
          ),
        ),
        bottomNavigationBar: const AppFooter(),
      );
    }

    final product = args;

    return Scaffold(
      appBar: const AppHeader(),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 900;
          final horizontalPadding = isMobile ? 16.0 : 40.0;
          final verticalPadding = isMobile ? 16.0 : 32.0;

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: isMobile
                      ? _buildMobileContent(product)
                      : _buildDesktopContent(product),
                ),
                const Divider(height: 0),
                const AppFooter(),
              ],
            ),
          );
        },
      ),
    );
  }

  // ---------- IMAGE LIST HELPER ----------

  /// For now, we only have one image (product.imageUrl).
  /// If you later extend Product with more images, just update this method.
  List<String> _productImages(Product product) {
    // If gallery images are provided, prefer them (they may include the main image
    // plus thumbnails). Otherwise fall back to the single imageUrl field.
    if (product.galleryImages.isNotEmpty) {
      return product.galleryImages;
    }
    return [product.imageUrl];
  }

  // ---------- LAYOUTS ----------

  Widget _buildDesktopContent(Product product) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT – images
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMainImage(product),
              const SizedBox(height: 16),
              _buildThumbnailsRow(product),
              const SizedBox(height: 24),

              // description moved into the right-hand details panel
            ],
          ),
        ),
        const SizedBox(width: 40),
        // RIGHT – product details
        Expanded(
          flex: 5,
          child: _ProductDetailsPanel(
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
          ),
        ),
      ],
    );
  }

  Widget _buildMobileContent(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMainImage(product),
        const SizedBox(height: 16),
        _buildThumbnailsRow(product),
        const SizedBox(height: 24),

        // description moved into the right-hand details panel

        _ProductDetailsPanel(
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
        ),
      ],
    );
  }

  // ---------- IMAGES ----------

  Widget _buildMainImage(Product product) {
    final images = _productImages(product);

    if (images.isEmpty) {
      return AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade200,
          ),
          child: const Text('No image'),
        ),
      );
    }

    final imageUrl = images[_selectedImageIndex];

    return AspectRatio(
      aspectRatio: 1.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: AdaptiveImage(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildThumbnailsRow(Product product) {
    final images = _productImages(product);
    if (images.length <= 1) {
      // Only one image – no thumbnails needed (but layout supports more)
      return const SizedBox.shrink();
    }

    return Row(
      children: List.generate(images.length, (index) {
        final path = images[index];
        final isSelected = index == _selectedImageIndex;

        return Padding(
          padding: EdgeInsets.only(right: index == images.length - 1 ? 0 : 8),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedImageIndex = index;
              });
            },
            child: _buildThumbnail(path, isSelected),
          ),
        );
      }),
    );
  }

  Widget _buildThumbnail(String imageUrl, bool isSelected) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? const Color(0xFF4D2963) : Colors.grey.shade300,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: AdaptiveImage(
          imageUrl,
          fit: BoxFit.cover,
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
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // Price + old price
        Row(
          children: [
            Text(
              priceText,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            if (oldPriceText != null)
              Text(
                oldPriceText,
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Tax included.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 24),

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

        // ADD TO CART (pill-shaped purple, like you wanted)
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
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4B2E83), // purple
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), // pill shape
              ),
              elevation: 2,
            ),
            child: const Text(
              'ADD TO CART',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Buy with Shop (also pill-shaped for consistency)
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              // TODO: hook up Shop Pay / external checkout if needed
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              side: BorderSide(color: Colors.grey.shade400),
            ),
            child: const Text('Buy with shop'),
          ),
        ),
        const SizedBox(height: 24),

        // Share buttons (like on personalisation page)
        Row(
          children: [
            _shareButton('SHARE'),
            const SizedBox(width: 8),
            _shareButton('TWEET'),
            const SizedBox(width: 8),
            _shareButton('PIN IT'),
          ],
        ),
        const SizedBox(height: 24),

        // Move product information here so it appears under the action buttons
        if (product.description.isNotEmpty) ...[
          const Divider(),
          const SizedBox(height: 12),
          const Text(
            "Product Information",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.description,
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
        ],
      ],
    );
  }

  Widget _shareButton(String label) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade400),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      onPressed: () {
        // TODO: implement real sharing if needed
      },
      child: Text(label),
    );
  }
}
