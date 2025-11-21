import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/sale.dart';
import 'package:union_shop/widgets/app_header.dart';

import 'package:union_shop/merch_page.dart';
import 'package:union_shop/halloween_page.dart';
import 'package:union_shop/signature_page.dart';
import 'package:union_shop/clothing.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      // Start at '/'
      initialRoute: '/',
      // All named routes (INCLUDING HOME)
      routes: {
        '/': (context) => const HomeScreen(),
        '/product': (context) => const ProductPage(),
        '/sale': (context) => const SalePage(),
        '/clothing': (context) => const ClothingPage(),
        '/merch': (context) => const MerchPage(),
        '/halloween': (context) => const HalloweenPage(),
        '/signature': (context) => const SignaturePage(),
        '/collections': (context) => const CollectionsPage(),
        '/about': (context) => const AboutPage(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void navigateToCollections(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  void navigateToSale(BuildContext context) {
    Navigator.pushNamed(context, '/sale');
  }

  void navigateToSimilar(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    // Header is handled by AppHeader
    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            // Hero Section
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ),
                  // Content overlay
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Placeholder Hero Title',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "This is placeholder text for the hero section.",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: placeholderCallbackForButtons,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: const Text(
                            'BROWSE PRODUCTS',
                            style: TextStyle(fontSize: 14, letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Products Section
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    const Text(
                      'PRODUCTS SECTION',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 48),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 2 : 1,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 48,
                      children: const [
                        ProductCard(
                          title: 'Placeholder Product 1',
                          price: '£10.00',
                          imageUrl:
                              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                        ),
                        ProductCard(
                          title: 'Placeholder Product 2',
                          price: '£15.00',
                          imageUrl:
                              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                        ),
                        ProductCard(
                          title: 'Placeholder Product 3',
                          price: '£20.00',
                          imageUrl:
                              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                        ),
                        ProductCard(
                          title: 'Placeholder Product 4',
                          price: '£25.00',
                          imageUrl:
                              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Footer
            Container(
              width: double.infinity,
              color: Colors.grey[50],
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 600;
                      // Narrow: stack sections vertically for phones
                      if (isNarrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Opening hours
                            const Text(
                              'Opening Hours',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('Mon - Fri: 09:00 - 17:00'),
                            const Text('Sat: 10:00 - 16:00'),
                            const Text('Sun: Closed'),
                            const SizedBox(height: 16),

                            // Help / Links
                            const Text(
                              'Help',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: placeholderCallbackForButtons,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft,
                              ),
                              child: const Text('Contact Us'),
                            ),
                            TextButton(
                              onPressed: placeholderCallbackForButtons,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft,
                              ),
                              child: const Text('Shipping & Returns'),
                            ),
                            TextButton(
                              onPressed: placeholderCallbackForButtons,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft,
                              ),
                              child: const Text('Privacy Policy'),
                            ),
                            const SizedBox(height: 16),

                            // Email subscription (stacked)
                            const Text(
                              'Subscribe',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: placeholderCallbackForButtons,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4d2963),
                                ),
                                child: const Text('Subscribe'),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "We\'ll never share your email.",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        );
                      }

                      // Wide: three columns side-by-side
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Opening hours
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Opening Hours',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text('Mon - Fri: 09:00 - 17:00'),
                                Text('Sat: 10:00 - 16:00'),
                                Text('Sun: Closed'),
                              ],
                            ),
                          ),

                          // Help / Links
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Help',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextButton(
                                  onPressed: placeholderCallbackForButtons,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  child: const Text('Contact Us'),
                                ),
                                TextButton(
                                  onPressed: placeholderCallbackForButtons,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  child: const Text('Shipping & Returns'),
                                ),
                                TextButton(
                                  onPressed: placeholderCallbackForButtons,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  child: const Text('Privacy Policy'),
                                ),
                              ],
                            ),
                          ),

                          // Email subscription
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Subscribe',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Enter your email',
                                          border: OutlineInputBorder(),
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: placeholderCallbackForButtons,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF4d2963),
                                      ),
                                      child: const Text('Subscribe'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "We\'ll never share your email.",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      '© ${DateTime.now().year} Union Shop',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Shop dropdown has been moved to a reusable widget in
// lib/widgets/shop_nav_dropdown.dart
