import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/specific_collection_page.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/personalisation_product.dart';
import 'package:union_shop/print_shack_personalisation.dart';
import 'package:union_shop/widgets/adaptive_image.dart';

// Sample products used for demo/showing collections. Replace with real data later.
const Map<String, List<Product>> _sampleProducts = {
  'Autumn Favourites': [
    Product(
      id: 'autumn-1',
      title: 'Autumn Hoodie',
      price: 29.99,
      imageUrl: 'assets/images/hoodie_green.png',
    ),
    Product(
      id: 'autumn-2',
      title: 'Autumn T-Shirt',
      price: 14.99,
      imageUrl: 'assets/images/tshirts.png',
    ),
  ],
  'Black Friday': [
    Product(
      id: 'bf-1',
      title: 'Black Friday Mug',
      price: 6.99,
      imageUrl: 'assets/images/mug.png',
    ),
  ],
  'Clothing': [
    Product(
      id: 'cloth-1',
      title: 'Classic Hoodie',
      price: 39.99,
      imageUrl: 'assets/images/hoodie_blue.png',
    ),
  ],
  'Accessories': [
    Product(
      id: 'tote-bag',
      title: 'Tote Bag',
      price: 3.50,
      imageUrl: 'assets/images/tote_bag.png',
    ),
    Product(
      id: 'postcard-pack',
      title: 'Postcard',
      price: 2.25,
      imageUrl: 'assets/images/postcard.png',
    ),
    Product(
      id: 'city-badge',
      title: 'City Badge',
      price: 4.00,
      imageUrl: 'assets/images/badge.png',
    ),
  ],
  'Gift Ideas': [
    Product(
      id: 'postcard-pack',
      title: 'Postcard',
      price: 10.00,
      imageUrl: 'assets/images/postcard.png',
    ),
    Product(
      id: 'gift-mug',
      title: 'Mug',
      price: 12.99,
      imageUrl: 'assets/images/mug.png',
    ),
    Product(
      id: 'gift-noteset',
      title: 'Notepad Set',
      price: 5.50,
      imageUrl: 'assets/images/notebook.png',
    ),
  ],
  'Essentials': [
    Product(
      id: 'ess-tote-bag',
      title: 'Reusable Tote Bag',
      price: 6.00,
      imageUrl: 'assets/images/tote_bag.png',
    ),
    Product(
      id: 'ess-tee-black',
      title: 'Classic Tee - Black',
      price: 14.99,
      imageUrl: 'assets/images/tshirts.png',
    ),
    Product(
      id: 'ess-crystal-ball',
      title: 'Crystal Ball',
      price: 3.99,
      imageUrl: 'assets/images/crystal_ball.png',
    ),
  ],
};

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void placeholderCallbackForButtons() {
    // placeholder for help links
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        width > 900 ? 96.0 : (width > 600 ? 48.0 : 24.0);

    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== COLLECTIONS CONTENT (no hero) =====
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Collections',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 32),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final bool threeCols = constraints.maxWidth >= 1100;
                      final bool twoCols = constraints.maxWidth >= 720;

                      int columns = 1;
                      if (threeCols) {
                        columns = 3;
                      } else if (twoCols) {
                        columns = 2;
                      }

                      const double spacing = 24.0;
                      final double cardWidth =
                          (constraints.maxWidth - spacing * (columns - 1)) /
                              columns;

                      return Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: [
                          CollectionCard(
                            title: 'Autumn Favourites',
                            width: cardWidth,
                            imageUrl: 'assets/images/autumn.png',
                          ),
                          CollectionCard(
                            title: 'Black Friday',
                            width: cardWidth,
                            imageUrl: 'assets/images/black_friday.png',
                          ),
                          CollectionCard(
                            title: 'Clothing',
                            width: cardWidth,
                            imageUrl: 'assets/images/clothing.png',
                          ),
                          CollectionCard(
                            title: 'Personalise',
                            width: cardWidth,
                            imageUrl: 'assets/images/personalise.png',
                            onTap: () {
                              final product = PersonalisationProduct(
                                id: 'ps-default',
                                title: 'T-Shirt Personalisation',
                                price: 8.00,
                                images: ['assets/images/personalise.png'],
                                perLineOptions: [
                                  'One Line of Text',
                                  'Two Lines of Text'
                                ],
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PrintShackPersonalisationPage(
                                    product: product,
                                  ),
                                ),
                              );
                            },
                          ),
                          CollectionCard(
                            title: 'Gift Ideas',
                            width: cardWidth,
                            imageUrl: 'assets/images/gifts.png',
                          ),
                          CollectionCard(
                            title: 'Essentials',
                            width: cardWidth,
                            imageUrl: 'assets/images/essentials.png',
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            // Shared footer
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

class CollectionCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double width;
  final VoidCallback? onTap;

  const CollectionCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            // Default behavior: push SpecificCollectionPage and pass sample products for the tapped collection.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SpecificCollectionPage(
                  title: title,
                  products: _sampleProducts[title] ?? const <Product>[],
                ),
              ),
            );
          },
      child: SizedBox(
        width: width,
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                AdaptiveImage(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: const Color.fromRGBO(0, 0, 0, 0.35),
                ),
                Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// _NavLink removed; AppHeader centralizes navigation links.
