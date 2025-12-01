import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart_model.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('CartModel', () {
    late CartModel cart;
    late Product p1;
    late Product p2;

    setUp(() {
      cart = CartModel();
      p1 = const Product(
        id: 'p1',
        title: 'Product 1',
        price: 5.0,
        imageUrl: 'https://example.com/p1.jpg',
      );
      p2 = const Product(
        id: 'p2',
        title: 'Product 2',
        price: 3.5,
        imageUrl: 'https://example.com/p2.jpg',
      );
    });

    test('starts empty', () {
      expect(cart.items, isEmpty);
      expect(cart.totalQuantity, 0);
      expect(cart.subtotal, 0.0);
    });

    test('addItem adds new item and updates totals', () {
      cart.addItem(p1, quantity: 2);
      expect(cart.items.length, 1);
      expect(cart.totalQuantity, 2);
      expect(cart.subtotal, 10.0);
    });

    test('addItem merges same product+options', () {
      cart.addItem(p1, quantity: 1);
      cart.addItem(p1, quantity: 3);
      expect(cart.items.length, 1);
      expect(cart.totalQuantity, 4);
      expect(cart.subtotal, 20.0);
    });

    test('addItem with different options creates separate line', () {
      cart.addItem(p1, quantity: 1);
      cart.addItem(p1, color: 'Red', quantity: 1);
      expect(cart.items.length, 2);
      expect(cart.totalQuantity, 2);
    });

    test('updateQuantity changes quantity and subtotal', () {
      cart.addItem(p2, quantity: 2);
      final item = cart.items.first;
      cart.updateQuantity(item, 5);
      expect(cart.totalQuantity, 5);
      expect(cart.subtotal, closeTo(17.5, 0.001));
    });

    test('removeItem removes and clear clears', () {
      cart.addItem(p1);
      cart.addItem(p2);
      expect(cart.items.length, 2);
      cart.removeItem(cart.items.first);
      expect(cart.items.length, 1);
      cart.clear();
      expect(cart.items, isEmpty);
    });
  });
}
