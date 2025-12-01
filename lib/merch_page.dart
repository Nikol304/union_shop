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
          imageUrl:
              'https://images.pexels.com/photos/1002638/pexels-photo-1002638.jpeg',
        ),
        Product(
          id: 'union-mug',
          title: 'Union Mug',
          price: 6.00,
          imageUrl:
              'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg',
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
