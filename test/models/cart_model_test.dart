import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart_model.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('CartModel (models/cart_model_test.dart)', () {
    late CartModel cart;
    late Product prodA;
    late Product prodB;

    setUp(() {
      cart = CartModel();
      prodA = const Product(
        id: 'a',
        title: 'Alpha',
        price: 5.0,
        imageUrl: '',
      );
      prodB = const Product(
        id: 'b',
        title: 'Beta',
        price: 3.0,
        imageUrl: '',
      );
    });

    test('addItem increments quantity for same product+variant', () {
      cart.addItem(prodA, quantity: 2, color: 'Red', size: 'M');
      expect(cart.items.length, 1);
      expect(cart.totalQuantity, 2);

      // add same product + same options -> quantity increments
      cart.addItem(prodA, quantity: 3, color: 'Red', size: 'M');
      expect(cart.items.length, 1);
      expect(cart.totalQuantity, 5);
      expect(cart.subtotal, closeTo(25.0, 0.001));
    });

    test('addItem with different options creates separate line items', () {
      cart.addItem(prodA, quantity: 1, color: 'Red', size: 'M');
      cart.addItem(prodA, quantity: 1, color: 'Blue', size: 'M');
      expect(cart.items.length, 2);
      expect(cart.totalQuantity, 2);
    });

    test('removeItem decreases and removes when quantity reaches 0', () {
      cart.addItem(prodA, quantity: 2);
      final item = cart.items.first;

      // update quantity to 1
      cart.updateQuantity(item, 1);
      expect(cart.totalQuantity, 1);

      // update quantity to 0 -> should remove
      cart.updateQuantity(item, 0);
      expect(cart.items, isEmpty);
      expect(cart.totalQuantity, 0);
    });

    test('total price calculation matches expected for multiple items', () {
      cart.addItem(prodA, quantity: 2); // 2 * 5 = 10
      cart.addItem(prodB, quantity: 3); // 3 * 3 = 9
      expect(cart.subtotal, closeTo(19.0, 0.001));
      expect(cart.totalQuantity, 5);
    });

    test('clear empties cart and resets totals', () {
      cart.addItem(prodA, quantity: 1);
      cart.addItem(prodB, quantity: 2);
      expect(cart.items, isNotEmpty);
      cart.clear();
      expect(cart.items, isEmpty);
      expect(cart.totalQuantity, 0);
      expect(cart.subtotal, 0.0);
    });

    test('item metadata (color/size) preserved per line item', () {
      cart.addItem(prodA, quantity: 1, color: 'Green', size: 'S');
      final item = cart.items.first;
      expect(item.selectedColor, 'Green');
      expect(item.selectedSize, 'S');
    });

    test('checkout moves cart into orderHistory and clears cart', () {
      cart.addItem(prodA, quantity: 1);
      cart.checkout();
      expect(cart.items, isEmpty);
      expect(cart.orderHistory.length, greaterThanOrEqualTo(1));
      final order = cart.orderHistory.last;
      expect(order.first.product.id, prodA.id);
      expect(order.first.quantity, 1);
    });
  });
}
