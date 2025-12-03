import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/specific_collection_page.dart';

class MerchPage extends StatelessWidget {
  const MerchPage({super.key});

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

  // You can make this const if you like
  List<Product> get _merchProducts => const [
        Product(
          id: 'union-tote-bag',
          title: 'Union Tote Bag',
          price: 8.00,
          imageUrl: 'assets/images/tote_bag.png',
          galleryImages: const [
            'assets/images/tote_bag.png',
            'assets/images/Halloween_bag.png',
          ],
        ),
        Product(
          id: 'union-mug',
          title: 'Union Mug',
          price: 6.00,
          imageUrl: 'assets/images/mug.png',
        ),
        // add more merch items…
      ];

  @override
  Widget build(BuildContext context) {
    return SpecificCollectionPage(
      title: 'Merchandise',
      products: _merchProducts,
    );
  }
}
