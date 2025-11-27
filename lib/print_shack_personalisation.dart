import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';

class PrintShackPersonalisationPage extends StatefulWidget {
  const PrintShackPersonalisationPage({Key? key}) : super(key: key);

  @override
  State<PrintShackPersonalisationPage> createState() =>
      _PrintShackPersonalisationPageState();
}

class _PrintShackPersonalisationPageState
    extends State<PrintShackPersonalisationPage> {
  String _perLineValue = 'One Line of Text';
  final TextEditingController _personalisationController =
      TextEditingController();
  final TextEditingController _quantityController =
      TextEditingController(text: '1');

  @override
  void dispose() {
    _personalisationController.dispose();
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
                // Footer
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
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      // Replace with your image
                      image: AssetImage('assets/personalisation_main.jpg'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildThumbnail('assets/personalisation_main.jpg', true),
                  const SizedBox(width: 8),
                  _buildThumbnail('assets/personalisation_alt.jpg', false),
                ],
              ),
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
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/personalisation_main.jpg'),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildThumbnail('assets/personalisation_main.jpg', true),
            const SizedBox(width: 8),
            _buildThumbnail('assets/personalisation_alt.jpg', false),
          ],
        ),
        const SizedBox(height: 24),
        _buildProductForm(),
      ],
    );
  }

  // ---------- PRODUCT FORM ----------

  Widget _buildProductForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personalisation',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          '£3.00',
          style: TextStyle(
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
            const Text(
              'One Line of Text',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 260,
          child: DropdownButtonFormField<String>(
            value: _perLineValue,
            items: const [
              DropdownMenuItem(
                value: 'One Line of Text',
                child: Text('One Line of Text'),
              ),
              DropdownMenuItem(
                value: 'Two Lines of Text',
                child: Text('Two Lines of Text'),
              ),
            ],
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
        const SizedBox(height: 24),

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
                // TODO: handle add to cart
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

  // ---------- FOOTER ----------
  // footer replaced with the standard site footer in the build method above

  // ---------- SMALL HELPERS ----------

  Widget _buildThumbnail(String asset, bool isSelected) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? const Color(0xFF4D2963) : Colors.grey.shade300,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
          image: AssetImage(asset),
          fit: BoxFit.cover,
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
