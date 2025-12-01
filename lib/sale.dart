import 'package:flutter/material.dart';
import 'package:union_shop/data/dummy_products.dart';
import 'package:union_shop/specific_collection_page.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  // ===== NAV HELPERS =====
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
    // placeholder
  }

  @override
  Widget build(BuildContext context) {
    final saleProducts = allProducts.where((p) => p.isOnSale).toList();

    return SpecificCollectionPage(
      title: 'SALE!',
      products: saleProducts,
    );
  }
}

// ===== Models & small widgets =====

// local models and helpers removed — page now delegates to SpecificCollectionPage
