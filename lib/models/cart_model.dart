// lib/models/cart_model.dart
import 'package:flutter/foundation.dart';
import 'package:union_shop/models/product.dart';

class CartItem {
  final Product product;
  final String? selectedColor;
  final String? selectedSize;
  int quantity;

  CartItem({
    required this.product,
    this.selectedColor,
    this.selectedSize,
    this.quantity = 1,
  });

  double get lineTotal => product.price * quantity;
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  // Optionally keep simple order history in memory
  final List<List<CartItem>> _orderHistory = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalQuantity => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.lineTotal);

  void addItem(
    Product product, {
    String? color,
    String? size,
    int quantity = 1,
  }) {
    if (quantity <= 0) return;

    final existing = _items.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedColor == color &&
          item.selectedSize == size,
    );

    if (existing >= 0) {
      _items[existing].quantity += quantity;
    } else {
      _items.add(
        CartItem(
          product: product,
          selectedColor: color,
          selectedSize: size,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(item);
      return;
    }
    final index = _items.indexOf(item);
    if (index == -1) return;
    _items[index].quantity = newQuantity;
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  /// Simulate placing an order (no real payment).
  void checkout() {
    if (_items.isEmpty) return;

    // Save a snapshot of the current cart as a "placed order" (optional)
    _orderHistory.add(_items
        .map((item) => CartItem(
              product: item.product,
              selectedColor: item.selectedColor,
              selectedSize: item.selectedSize,
              quantity: item.quantity,
            ))
        .toList());

    // Clear cart
    _items.clear();
    notifyListeners();
  }

  List<List<CartItem>> get orderHistory => List.unmodifiable(_orderHistory);
}
