import 'package:flutter/material.dart';
import 'package:union_shop/data/dummy_products.dart';
import 'package:union_shop/specific_collection_page.dart';

class ClothingPage extends StatelessWidget {
  const ClothingPage({super.key});

  // ---------- NAV HELPERS ----------
  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void navigateToCollections(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  void navigateToSale(BuildContext context) {
    Navigator.pushNamed(context, '/sale');
  }

  void navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void placeholderCallbackForButtons() {
    // placeholder for now
  }

  @override
  Widget build(BuildContext context) {
    final clothingProducts = allProducts
        .where((p) => p.category == 'clothing')
        .toList();

    return SpecificCollectionPage(
      title: 'Clothing',
      products: clothingProducts,
    );
  }
}

// _NavLink removed; AppHeader provides navigation links.
