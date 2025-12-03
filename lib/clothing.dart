import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/specific_collection_page.dart';

class ClothingPage extends StatelessWidget {
  const ClothingPage({super.key});

  // You can make this const if you like
  List<Product> get _clothingProducts => const [
        Product(
          id: 'classic-hoodies',
          title: 'Classic Hoodies',
          price: 25.00,
          imageUrl: 'assets/images/hoodie_grey.png',
        ),
        Product(
          id: 'classic-sweatshirts',
          title: 'Classic Sweatshirts',
          price: 23.00,
          imageUrl: 'assets/images/hoodie_red.png',
        ),
        Product(
          id: 'classic-tshirts',
          title: 'Classic T-Shirts',
          price: 15.00,
          imageUrl: 'assets/images/classic_tshirt.png',
        ),
        // Continue converting your other _ClothingProduct entries here:
        // Product(
        //   id: 'classic-shorts',
        //   title: 'Classic Shorts',
        //   price: 17.00,
        //   imageUrl: 'https://...',
        // ),
      ];

  @override
  Widget build(BuildContext context) {
    return SpecificCollectionPage(
      title: 'Clothing',
      products: _clothingProducts,
    );
  }
}
