import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/specific_collection_page.dart';
import 'package:union_shop/models/product.dart';

// Sample products used for demo/showing collections. Replace with real data later.
const Map<String, List<Product>> _sampleProducts = {
  'Autumn Favourites': [
    Product(
      id: 'autumn-1',
      title: 'Autumn Hoodie',
      price: 29.99,
      imageUrl:
          'https://images.pexels.com/photos/936048/pexels-photo-936048.jpeg',
    ),
    Product(
      id: 'autumn-2',
      title: 'Autumn T-Shirt',
      price: 14.99,
      imageUrl:
          'https://images.pexels.com/photos/428343/pexels-photo-428343.jpeg',
    ),
  ],
  'Black Friday': [
    Product(
      id: 'bf-1',
      title: 'Black Friday Mug',
      price: 6.99,
      imageUrl:
          'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg',
    ),
  ],
  'Clothing': [
    Product(
      id: 'cloth-1',
      title: 'Classic Hoodie',
      price: 39.99,
      imageUrl:
          'https://images.pexels.com/photos/428338/pexels-photo-428338.jpeg',
    ),
  ],
  'Accessories': [],
  'Gift Ideas': [],
  'Essentials': [],
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
                            imageUrl:
                                'https://images.pexels.com/photos/3760851/pexels-photo-3760851.jpeg',
                          ),
                          CollectionCard(
                            title: 'Black Friday',
                            width: cardWidth,
                            imageUrl:
                                'https://images.pexels.com/photos/5650023/pexels-photo-5650023.jpeg',
                          ),
                          CollectionCard(
                            title: 'Clothing',
                            width: cardWidth,
                            imageUrl:
                                'https://images.pexels.com/photos/7671166/pexels-photo-7671166.jpeg',
                          ),
                          CollectionCard(
                            title: 'Accessories',
                            width: cardWidth,
                            imageUrl:
                                'https://images.pexels.com/photos/298864/pexels-photo-298864.jpeg',
                          ),
                          CollectionCard(
                            title: 'Gift Ideas',
                            width: cardWidth,
                            imageUrl:
                                'https://images.pexels.com/photos/1304640/pexels-photo-1304640.jpeg',
                          ),
                          CollectionCard(
                            title: 'Essentials',
                            width: cardWidth,
                            imageUrl:
                                'https://images.pexels.com/photos/2983464/pexels-photo-2983464.jpeg',
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

  const CollectionCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Push SpecificCollectionPage and pass sample products for the tapped collection.
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
                Image.network(
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
