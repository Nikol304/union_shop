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
          imageUrl:
              'https://images.pexels.com/photos/7671166/pexels-photo-7671166.jpeg',
        ),
        Product(
          id: 'classic-sweatshirts',
          title: 'Classic Sweatshirts',
          price: 23.00,
          imageUrl:
              'https://images.pexels.com/photos/7671173/pexels-photo-7671173.jpeg',
        ),
        Product(
          id: 'classic-tshirts',
          title: 'Classic T-Shirts',
          price: 15.00,
          imageUrl:
              'https://images.pexels.com/photos/7697491/pexels-photo-7697491.jpeg',
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
