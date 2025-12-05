import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('Product model', () {
    test('constructs with required fields and default galleryImages', () {
      const p = Product(
        id: 'p-1',
        title: 'Test Product',
        price: 12.5,
        imageUrl: 'assets/images/test.png',
      );

      expect(p.id, 'p-1');
      expect(p.title, 'Test Product');
      expect(p.price, 12.5);
      expect(p.imageUrl, 'assets/images/test.png');

      // defaults
      expect(p.galleryImages, isA<List<String>>());
      expect(p.galleryImages, isEmpty);
      expect(p.description, isEmpty);
      expect(p.category, isEmpty);
      expect(p.collection, isEmpty);
      expect(p.inStock, isTrue);
      expect(p.isOnSale, isFalse);
    });

    test('optional fields are preserved when provided', () {
      const p = Product(
        id: 'p-2',
        title: 'With extras',
        price: 9.99,
        imageUrl: 'http://example.com/i.png',
        oldPrice: 19.99,
        galleryImages: ['a.png', 'b.png'],
        description: 'A product',
        category: 'clothing',
        collection: 'essentials',
        inStock: false,
        isOnSale: true,
      );

      expect(p.oldPrice, 19.99);
      expect(p.galleryImages, ['a.png', 'b.png']);
      expect(p.description, 'A product');
      expect(p.category, 'clothing');
      expect(p.collection, 'essentials');
      expect(p.inStock, isFalse);
      expect(p.isOnSale, isTrue);
    });

    test('name getter returns title (backwards compatibility)', () {
      const p = Product(
        id: 'p-3',
        title: 'Compatibility',
        price: 1.0,
        imageUrl: '',
      );

      expect(p.name, p.title);
    });
  });
}
