import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/models/personalisation_product.dart';
import 'package:union_shop/models/cart_model.dart';
import 'package:union_shop/models/product.dart';

class PrintShackPersonalisationPage extends StatefulWidget {
  final PersonalisationProduct product;

  const PrintShackPersonalisationPage({
    super.key,
    required this.product,
  });

  @override
  State<PrintShackPersonalisationPage> createState() =>
      _PrintShackPersonalisationPageState();
}

class _PrintShackPersonalisationPageState
    extends State<PrintShackPersonalisationPage> {
  late String _perLineValue;
  final TextEditingController _personalisationController =
      TextEditingController();
  final TextEditingController _personalisationLine2Controller =
      TextEditingController();
  final TextEditingController _quantityController =
      TextEditingController(text: '1');

  // which thumbnail is selected (for big image)
  int _selectedImageIndex = 0;

  @override
  void initState() {
    super.initState();
    // default dropdown value from model
    _perLineValue = widget.product.perLineOptions.first;
  }

  @override
  void dispose() {
    _personalisationController.dispose();
    _personalisationLine2Controller.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 900;

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
                  child:
                      isMobile ? _buildMobileContent() : _buildDesktopContent(),
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

  // ---------- MAIN CONTENT (DESKTOP) ----------

  Widget _buildDesktopContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT – Product images
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMainImage(),
              const SizedBox(height: 16),
              _buildThumbnailsRow(),
            ],
          ),
        ),

        const SizedBox(width: 40),

        // RIGHT – Product info + form
        Expanded(
          flex: 5,
          child: _buildProductForm(),
        ),
      ],
    );
  }

  // ---------- MAIN CONTENT (MOBILE) ----------

  Widget _buildMobileContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMainImage(),
        const SizedBox(height: 16),
        _buildThumbnailsRow(),
        const SizedBox(height: 24),
        _buildProductForm(),
      ],
    );
  }

  // ---------- IMAGES ----------

  Widget _buildMainImage() {
    final images = widget.product.images;

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
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey.shade200,
            alignment: Alignment.center,
            child: const Icon(Icons.image_not_supported, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnailsRow() {
    final images = widget.product.images;
    if (images.length <= 1) {
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

  // ---------- PRODUCT FORM ----------

  Widget _buildProductForm() {
    final product = widget.product;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '£${product.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
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

        // Per Line dropdown
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Per Line: ',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 4),
            Text(
              _perLineValue,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 260,
          child: DropdownButtonFormField<String>(
            value: _perLineValue,
            items: product.perLineOptions
                .map(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ),
                )
                .toList(),
            decoration: _inputDecoration(),
            onChanged: (val) {
              if (val != null) {
                setState(() => _perLineValue = val);
              }
            },
          ),
        ),
        const SizedBox(height: 24),

        // Personalisation line
        const Text(
          'Personalisation Line 1:',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _personalisationController,
          decoration: _inputDecoration(),
        ),
        const SizedBox(height: 16),

        if (_perLineValue == 'Two Lines of Text') ...[
          const Text(
            'Personalisation Line 2:',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _personalisationLine2Controller,
            decoration: _inputDecoration(),
          ),
          const SizedBox(height: 16),
        ],

        const SizedBox(height: 8),

        // Quantity
        const Text(
          'Quantity',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 100,
          child: TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration(),
          ),
        ),
        const SizedBox(height: 24),

        // Add to cart button
        SizedBox(
          width: double.infinity,
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4D2963),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              onPressed: () {
                final line1 = _personalisationController.text.trim();
                final line2 = _personalisationLine2Controller.text.trim();
                final qty = int.tryParse(_quantityController.text) ?? 1;

                // Basic validation
                if (line1.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in Personalisation Line 1.'),
                    ),
                  );
                  return;
                }

                if (_perLineValue == 'Two Lines of Text' && line2.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in Personalisation Line 2.'),
                    ),
                  );
                  return;
                }

                final textSummary = _perLineValue == 'Two Lines of Text'
                    ? '$line1 / $line2'
                    : line1;

                // Build a Product instance to add to the cart (personalisation
                // details baked into the title). Use the currently selected
                // image as the product image if available.
                final selectedImage = (widget.product.images.isNotEmpty)
                    ? widget.product.images[_selectedImageIndex]
                    : '';

                final personalisedProduct = Product(
                  id: '${widget.product.id}-${DateTime.now().millisecondsSinceEpoch}',
                  title: '${widget.product.title} — $textSummary',
                  price: widget.product.price,
                  imageUrl: selectedImage,
                );

                // Add to cart via provider
                Provider.of<CartModel>(context, listen: false)
                    .addItem(personalisedProduct, quantity: qty);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Personalisation added ($qty): $textSummary',
                    ),
                  ),
                );
              },
              child: const Text(
                'ADD TO CART',
                style: TextStyle(
                  letterSpacing: 1.4,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Small print
        const Text(
          '£3 for one line of text! £5 for two!\n\n'
          'One line of text is 10 characters.\n\n'
          'Please ensure all spellings are correct before submitting your purchase '
          'as we will print your item with the exact wording you provide. '
          'We will not be responsible for any incorrect spellings printed onto '
          'your garment. Personalised items do not qualify for refunds.',
          style: TextStyle(fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 24),

        // Share buttons (simple placeholders)
        Row(
          children: [
            _shareButton('SHARE'),
            const SizedBox(width: 8),
            _shareButton('TWEET'),
            const SizedBox(width: 8),
            _shareButton('PIN IT'),
          ],
        ),
      ],
    );
  }

  // ---------- SMALL HELPERS ----------

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
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey.shade200,
            alignment: Alignment.center,
            child: const Icon(Icons.image_not_supported, size: 20),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _shareButton(String label) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade400),
      ),
      onPressed: () {},
      child: Text(label),
    );
  }
}
