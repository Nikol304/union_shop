import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/models/cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // debug
    // ignore: avoid_print
    print('CartPage.build() called');

    final cart = context.watch<CartModel>();
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: const AppHeader(),
      // NOTE: footer is now INSIDE the scrollable body, not bottomNavigationBar
      body: ListView(
        children: [
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'Your cart',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
              child: Text(
                'Continue shopping',
                style: TextStyle(
                  color: primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),

          if (cart.items.isEmpty)
            const _EmptyCartMessage()
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _CartTable(cart: cart),
            ),

          const SizedBox(height: 40),

          // Footer at the bottom of the page
          const AppFooter(),
        ],
      ),
    );
  }
}

class _EmptyCartMessage extends StatelessWidget {
  const _EmptyCartMessage();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 80),
      child: Center(
        child: Text(
          'Your cart is currently empty.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class _CartTable extends StatelessWidget {
  final CartModel cart;

  const _CartTable({required this.cart});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header row: Product | Price | Quantity | Total
        Row(
          children: const [
            Expanded(
              flex: 5,
              child: Text(
                'Product',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Price',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Quantity',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Total',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 8),

        // All line items
        ...cart.items.map((item) => _CartRow(item: item)).toList(),

        const SizedBox(height: 32),

        // Bottom: note + subtotal / buttons
        LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 700;
            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _OrderNoteField(),
                  const SizedBox(height: 24),
                  _SubtotalAndActions(cart: cart, primary: primary),
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(flex: 5, child: _OrderNoteField()),
                SizedBox(width: 40),
                Expanded(flex: 3, child: _SubtotalAndActionsWrapper()),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _CartRow extends StatelessWidget {
  final CartItem item;

  const _CartRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartModel>();
    final primary = Theme.of(context).colorScheme.primary;
    final qtyController = TextEditingController(text: item.quantity.toString());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product cell: image + name + colour/size + "Remove"
          Expanded(
            flex: 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey[200],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    item.product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.product.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (item.selectedColor != null)
                        Text(
                          'Color: ${item.selectedColor}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      if (item.selectedSize != null)
                        Text(
                          'Size: ${item.selectedSize}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () => cart.removeItem(item),
                        child: Text(
                          'Remove',
                          style: TextStyle(
                            fontSize: 13,
                            color: primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Price
          Expanded(
            flex: 2,
            child: Text(
              '£${item.product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14),
            ),
          ),

          // Quantity box
          Expanded(
            flex: 2,
            child: SizedBox(
              width: 60,
              child: TextField(
                controller: qtyController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  final parsed = int.tryParse(value) ?? 1;
                  cart.updateQuantity(item, parsed);
                },
              ),
            ),
          ),

          // Line total
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '£${item.lineTotal.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderNoteField extends StatelessWidget {
  const _OrderNoteField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Add a note to your order',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

/// Tiny wrapper so we can reuse _SubtotalAndActions both in narrow & wide layouts.
class _SubtotalAndActionsWrapper extends StatelessWidget {
  const _SubtotalAndActionsWrapper();

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    final primary = Theme.of(context).colorScheme.primary;
    return _SubtotalAndActions(cart: cart, primary: primary);
  }
}

class _SubtotalAndActions extends StatelessWidget {
  final CartModel cart;
  final Color primary;

  const _SubtotalAndActions({
    required this.cart,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Subtotal',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '£${cart.subtotal.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Tax included and shipping calculated at checkout',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cart updated')),
                );
              },
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                side: BorderSide(color: primary),
                textStyle: const TextStyle(
                  letterSpacing: 1.3,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text('UPDATE'),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Checkout is not implemented in this coursework app.'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                textStyle: const TextStyle(
                  letterSpacing: 1.3,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text('CHECK OUT'),
            ),
          ],
        ),
      ],
    );
  }
}
