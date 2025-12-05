import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/specific_collection_page.dart';

class SignaturePage extends StatelessWidget {
  const SignaturePage({super.key});

  // Signature & Essential range products
  List<Product> get _signatureProducts => const [
        Product(
          id: 'signature-hoodie-black',
          title: 'Signature Hoodie Black',
          price: 14.99,
          imageUrl: 'assets/images/hoodie_black.png',
        ),
        Product(
          id: 'signature-hoodie-purple',
          title: 'Signature Hoodie Purple',
          price: 32.99,
          imageUrl: 'assets/images/hoodie_purple.png',
        ),
        Product(
          id: 'essential-hoodie-blue',
          title: 'Limited Edition Essential Hoodie Blue',
          price: 14.99,
          imageUrl: 'assets/images/hoodie_blue.png',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return SpecificCollectionPage(
      title: 'Signature & Essential Range',
      products: _signatureProducts,
    );
  }
}
