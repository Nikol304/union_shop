// lib/halloween_page.dart
import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/product_page.dart'; // <-- IMPORTANT: ensure this import exists

class HalloweenPage extends StatelessWidget {
  const HalloweenPage({super.key});

  // Your Halloween product defined once
  static const Product halloweenProduct = Product(
    id: 'halloween-tote',
    title: 'Halloween Tote Bags',
    price: 2.50,
    imageUrl: 'assets/images/Halloween_bag.png',
    description:
        'Trick or treat yourself to one of these limited edition Halloween tote bags! '
        'Available online & in-store for just £2.50!',
    galleryImages: const [
      'assets/images/Halloween_bag.png',
      'assets/images/tote_bag.png',
    ],
  );

  @override
  Widget build(BuildContext context) {
    // Immediately open ProductPage with the product data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(
        context,
        '/product',
        arguments: halloweenProduct,
      );
    });

    // While redirecting, show a blank page or loader
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
