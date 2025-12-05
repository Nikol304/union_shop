import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/specific_collection_page.dart';

// Sale page using the shared Product model and SpecificCollectionPage
class SalePage extends StatelessWidget {
  const SalePage({super.key});

  // Dummy sale products using the shared Product model
  static final List<Product> _saleProducts = [
    Product(
      id: 'sale-a5-notepad',
      title: 'A5 Notepad',
      price: 1.80,
      oldPrice: 3.00,
      imageUrl: 'assets/images/notebook.png',
    ),
    Product(
      id: 'sale-classic-sweatshirt-neutral',
      title: 'Classic Sweatshirts - Neutral',
      price: 10.99,
      oldPrice: 17.00,
      imageUrl: 'assets/images/sweatshirt_grey.png',
    ),
    Product(
      id: 'sale-recycled-notebook',
      title: 'Recycled Notebook',
      price: 1.80,
      imageUrl: 'assets/images/notebook.png',
    ),
    Product(
      id: 'sale-hoodie-blue',
      title: 'Hoodie Blue',
      price: 1.50,
      oldPrice: 3.00,
      imageUrl: 'assets/images/hoodie_blue.png',
    ),
    Product(
      id: 'sale-bookmark',
      title: 'Bookmark',
      price: 0.99,
      oldPrice: 1.50,
      imageUrl: 'assets/images/bookmark.png',
    ),
    Product(
      id: 'sale-hoodie-black',
      title: 'Hoodie Black',
      price: 7.00,
      oldPrice: 24.99,
      imageUrl: 'assets/images/hoodie_black.png',
    ),
    Product(
      id: 'sale-printed-mug',
      title: 'Printed Mug',
      price: 7.00, // or 0 + "Sold out" badge later if you extend the model
      imageUrl: 'assets/images/mug.png',
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
