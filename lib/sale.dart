import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/specific_collection_page.dart';

// Sale page using the shared Product model and SpecificCollectionPage
class SalePage extends StatelessWidget {
  const SalePage({super.key});

  // Dummy sale products using the shared Product model
  static const List<Product> _saleProducts = [
    Product(
      id: 'sale-a5-notepad',
      title: 'A5 Notepad',
      price: 1.80,
      imageUrl:
          'https://images.pexels.com/photos/950241/pexels-photo-950241.jpeg',
    ),
    Product(
      id: 'sale-classic-sweatshirt-neutral',
      title: 'Classic Sweatshirts - Neutral',
      price: 10.99,
      imageUrl:
          'https://images.pexels.com/photos/7671166/pexels-photo-7671166.jpeg',
    ),
    Product(
      id: 'sale-recycled-notebook',
      title: 'Recycled Notebook',
      price: 1.80,
      imageUrl:
          'https://images.pexels.com/photos/3831849/pexels-photo-3831849.jpeg',
    ),
    Product(
      id: 'sale-iphone-cable',
      title: 'iPhone Charge & Sync Cable',
      price: 1.50,
      imageUrl:
          'https://images.pexels.com/photos/1054389/pexels-photo-1054389.jpeg',
    ),
    Product(
      id: 'sale-dimple-pop-keyring',
      title: 'Dimple Pop Fidget Keyring',
      price: 0.99,
      imageUrl:
          'https://images.pexels.com/photos/3662718/pexels-photo-3662718.jpeg',
    ),
    Product(
      id: 'sale-nike-tech-pants-w',
      title: 'Nike Academy 18 Tech Pants (W)',
      price: 7.00,
      imageUrl:
          'https://images.pexels.com/photos/7671173/pexels-photo-7671173.jpeg',
    ),
    Product(
      id: 'sale-nike-tech-pants-m',
      title: 'Nike Academy 18 Tech Pants (M)',
      price: 7.00, // or 0 + "Sold out" badge later if you extend the model
      imageUrl:
          'https://images.pexels.com/photos/7671168/pexels-photo-7671168.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SpecificCollectionPage(
      title: 'Sale',
      subtitle: "Don't miss out! Get yours before they're all gone!",
      products: _saleProducts,
    );
  }
}
