import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/specific_collection_page.dart';

class SignaturePage extends StatelessWidget {
  const SignaturePage({super.key});

  // Signature & Essential range products
  List<Product> get _signatureProducts => const [
        Product(
          id: 'signature-tshirt',
          title: 'Signature T-Shirt',
          price: 14.99,
          imageUrl: 'assets/images/signature_tshirt.png',
        ),
        Product(
          id: 'signature-hoodie',
          title: 'Signature Hoodie',
          price: 32.99,
          imageUrl: 'assets/images/signature_hoodie.png',
        ),
        Product(
          id: 'essential-zip-hoodie',
          title: 'Limited Edition Essential Zip Hoodie',
          price: 14.99,
          imageUrl: 'assets/images/essential_zip_hoodie.png',
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
