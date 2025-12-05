import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_model.dart';
import 'package:union_shop/cart_page.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/sale.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/home_hero_carousel.dart';
import 'package:union_shop/widgets/app_footer.dart';

import 'package:union_shop/merch_page.dart';
import 'package:union_shop/halloween_page.dart';
import 'package:union_shop/signature_page.dart';
import 'package:union_shop/authentication.dart';
import 'package:union_shop/the_print_shack.dart';
import 'package:union_shop/clothing.dart';
import 'package:union_shop/print_shack_personalisation.dart';
import 'package:union_shop/models/personalisation_product.dart';
import 'package:union_shop/specific_collection_page.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/product_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key, this.enableHeroAutoSlide = true});

  final bool enableHeroAutoSlide;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartModel(),
      child: MaterialApp(
        title: 'Union Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
        ),
        // Start at '/'
        initialRoute: '/',
        // All named routes (INCLUDING HOME)
        routes: {
          '/': (context) =>
              HomeScreen(enableHeroAutoSlide: enableHeroAutoSlide),
          '/product': (context) => const ProductPage(),
          '/cart': (context) {
            // debug
            // ignore: avoid_print
            print('ROUTE: building CartPage');
            return const CartPage();
          },
          '/sale': (context) => const SalePage(),
          '/clothing': (context) => const ClothingPage(),
          '/merch': (context) => const MerchPage(),
          '/halloween': (context) => const HalloweenPage(),
          '/signature': (context) => const SignaturePage(),
          '/collections': (context) => const CollectionsPage(),
          '/collection': (context) => const SpecificCollectionPage(
              title: 'Collection', products: const <Product>[]),
          '/print-shack': (context) => const PrintShackPage(),
          '/print-shack-personalisation': (context) =>
              PrintShackPersonalisationPage(
                product: const PersonalisationProduct(
                  id: 'ps-sample',
                  title: 'Personalisation',
                  price: 3.0,
                  images: <String>[
                    'assets/images/personalise.png',
                    'assets/images/tshirts_folded.png',
                  ],
                  perLineOptions: <String>[
                    'One Line of Text',
                    'Two Lines of Text',
                  ],
                ),
              ),
          '/about': (context) => const AboutPage(),
          // Keep both route names mapping to the same authentication page for
          // backwards compatibility. Use '/authentication' as the canonical route.
          '/login': (context) => const AuthenticationPage(),
          '/authentication': (context) => const AuthenticationPage(),
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.enableHeroAutoSlide = true});

  final bool enableHeroAutoSlide;

  // ===== Dummy homepage data =====
  static const List<Product> _essentialRangeProducts = [
    Product(
      id: 'essential-zip-hoodie',
      title: 'Limited Edition Essential Zip Hoodies',
      price: 14.99,
      oldPrice: 20.00,
      imageUrl: 'assets/images/sweatshirt_grey.png',
      galleryImages: const [
        'assets/images/sweatshirt_grey.png',
        'assets/images/hoodie_grey.png',
      ],
    ),
    Product(
      id: 'essential-tshirt',
      title: 'Essential T-Shirt',
      price: 6.99,
      oldPrice: 10.00,
      imageUrl: 'assets/images/tshirts.png',
    ),
  ];

  static const List<Product> _signatureRangeProducts = [
    Product(
      id: 'signature-hoodie',
      title: 'Signature Hoodie',
      price: 32.99,
      imageUrl: 'assets/images/hoodie_green.png',
      galleryImages: const [
        'assets/images/hoodie_green.png',
        'assets/images/hoodie_grey.png',
        'assets/images/hoodie_red.png',
      ],
    ),
    Product(
      id: 'signature-tshirt',
      title: 'Signature T-Shirt',
      price: 14.99,
      imageUrl: 'assets/images/tshirts.png',
    ),
  ];

  static const List<Product> _portsmouthCityProducts = [
    Product(
      id: 'portsmouth-postcard',
      title: 'Portsmouth City Postcard',
      price: 1.00,
      imageUrl: 'assets/images/postcard.png',
    ),
    Product(
      id: 'portsmouth-magnet',
      title: 'Portsmouth City Magnet',
      price: 4.50,
      imageUrl: 'assets/images/magnet.png',
    ),
    Product(
      id: 'portsmouth-badge',
      title: 'Portsmouth City Badge',
      price: 3.50,
      imageUrl: 'assets/images/badge.png',
    ),
    Product(
      id: 'portsmouth-notebook',
      title: 'Portsmouth City Notebook',
      price: 6.00,
      imageUrl: 'assets/images/notebook.png',
    ),
    Product(
      id: 'portsmouth-crystal-ball',
      title: 'Portsmouth City Crystal Ball',
      price: 6.00,
      imageUrl: 'assets/images/crystal_ball.png',
    ),
    Product(
      id: 'portsmouth-bookmark',
      title: 'Portsmouth City Book Mark',
      price: 6.00,
      imageUrl: 'assets/images/bookmark.png',
    ),
  ];

  // ===== Navigation helpers (unchanged) =====
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

  void navigateToCollection(BuildContext context) {
    Navigator.pushNamed(context, '/collection');
  }

  void navigateToMerch(BuildContext context) {
    Navigator.pushNamed(context, '/merch');
  }

  void navigateToHalloween(BuildContext context) {
    Navigator.pushNamed(context, '/halloween');
  }

  void navigateToSignature(BuildContext context) {
    Navigator.pushNamed(context, '/signature');
  }

  void navigateToPrintShack(BuildContext context) {
    Navigator.pushNamed(context, '/print-shack');
  }

  void navigateToPrintShackPersonalisation(BuildContext context) {
    Navigator.pushNamed(context, '/print-shack-personalisation');
  }

  void navigateToSale(BuildContext context) {
    Navigator.pushNamed(context, '/sale');
  }

  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }

  void navigateToAuthentication(BuildContext context) {
    Navigator.pushNamed(context, '/authentication');
  }

  void navigateToSimilar(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void placeholderCallbackForButtons() {
    // placeholder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HERO
            HomeHeroCarousel(enableAutoSlide: enableHeroAutoSlide),

            // ESSENTIAL RANGE
            _HomeSection(
              title: 'ESSENTIAL RANGE - OVER 20% OFF!',
              products: _essentialRangeProducts,
              topPadding: 64,
              bottomPadding: 24,
            ),

            // SIGNATURE RANGE (new section, same layout)
            _HomeSection(
              title: 'SIGNATURE RANGE',
              products: _signatureRangeProducts,
              topPadding: 16,
              bottomPadding: 24,
            ),

            // PORTSMOUTH CITY COLLECTION (now 4 products)
            _HomeSection(
              title: 'PORTSMOUTH CITY COLLECTION',
              products: _portsmouthCityProducts,
              topPadding: 16,
              bottomPadding: 32,
            ),

            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

/// Reusable homepage section

class _HomeSection extends StatelessWidget {
  final String title;
  final List<Product> products;
  final double topPadding;
  final double bottomPadding;

  const _HomeSection({
    required this.title,
    required this.products,
    this.topPadding = 32,
    this.bottomPadding = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool wide = constraints.maxWidth >= 900;
                  final int crossAxisCount = wide ? 2 : 1;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      // Make items a bit taller so content fits
                      childAspectRatio: wide ? 1.0 : 0.8,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Shop dropdown has been moved to a reusable widget in
// lib/widgets/shop_nav_dropdown.dart
