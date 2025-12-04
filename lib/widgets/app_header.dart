import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_model.dart';
import 'package:union_shop/widgets/shop_nav_dropdown.dart';
import 'package:union_shop/widgets/print_shack_nav_dropdown.dart';
import 'package:union_shop/widgets/adaptive_image.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    void navigateTo(String routeName) {
      if (ModalRoute.of(context)?.settings.name == routeName) return;
      Navigator.pushNamed(context, routeName);
    }

    void navigateToHome() {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }

    return Container(
      height: preferredSize.height,
      color: Colors.white,
      child: Column(
        children: [
          // TOP BANNER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF4d2963),
            child: const Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          // MAIN HEADER BAR
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // Logo
                  GestureDetector(
                    onTap: navigateToHome,
                    child: AdaptiveImage(
                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                      fit: BoxFit.cover,
                      height: 35,
                    ),
                  ),
                  const SizedBox(width: 32),

                  // Desktop nav links
                  if (!isMobile)
                    Row(
                      children: [
                        _NavLink(
                          label: 'Home',
                          onTap: navigateToHome,
                        ),
                        const ShopNavDropdown(),
                        _NavLink(
                          label: 'Collections',
                          onTap: () => navigateTo('/collections'),
                        ),
                        const PrintShackNavDropdown(),
                        _NavLink(
                          label: 'Sale',
                          onTap: () => navigateTo('/sale'),
                        ),
                        _NavLink(
                          label: 'About',
                          onTap: () => navigateTo('/about'),
                        ),
                      ],
                    ),

                  const Spacer(),

                  // Right side icons (+ mobile menu)
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Search icon (stub for now)
                        IconButton(
                          icon: const Icon(
                            Icons.search,
                            size: 18,
                            color: Colors.grey,
                          ),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          onPressed: () {
                            // TODO: implement search
                          },
                        ),

                        // Account icon
                        IconButton(
                          icon: const Icon(
                            Icons.person_outline,
                            size: 18,
                            color: Colors.grey,
                          ),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/authentication');
                          },
                        ),

                        // Cart icon + badge
                        Consumer<CartModel>(
                          builder: (context, cart, _) {
                            final count = cart.totalQuantity;
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: () {
                                    // ignore: avoid_print
                                    print('AppHeader: cart icon tapped');
                                    Navigator.pushNamed(context, '/cart');
                                  },
                                ),
                                if (count > 0)
                                  Positioned(
                                    right: 6,
                                    top: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        '$count',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),

                        // MOBILE-ONLY SANDWICH MENU
                        if (isMobile)
                          IconButton(
                            icon: const Icon(
                              Icons.menu,
                              size: 20,
                              color: Colors.grey,
                            ),
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MobileMenuPage(),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink({required this.label, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

/// =======================
///  MOBILE MENU PAGE
/// =======================

enum _MobileMenuSection {
  root,
  shop,
  printShack,
}

class MobileMenuPage extends StatefulWidget {
  const MobileMenuPage({Key? key}) : super(key: key);

  @override
  State<MobileMenuPage> createState() => _MobileMenuPageState();
}

class _MobileMenuPageState extends State<MobileMenuPage> {
  _MobileMenuSection _section = _MobileMenuSection.root;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // TOP BANNER (same as main)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: const Color(0xFF4d2963),
              child: const Text(
                'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

            // HEADER ROW (logo + icons + X)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: isMobile ? 56 : 64,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    },
                    child: AdaptiveImage(
                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                      fit: BoxFit.cover,
                      height: 32,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 18,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      // TODO search
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.person_outline,
                      size: 18,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/authentication');
                    },
                  ),
                  Consumer<CartModel>(
                    builder: (context, cart, _) {
                      final count = cart.totalQuantity;
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.shopping_bag_outlined,
                              size: 18,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              Navigator.popAndPushNamed(context, '/cart');
                            },
                          ),
                          if (count > 0)
                            Positioned(
                              right: 6,
                              top: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '$count',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // MENU CONTENT
            Expanded(
              child: ListView(
                children: _buildMenuContent(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMenuContent(BuildContext context) {
    switch (_section) {
      case _MobileMenuSection.root:
        return _buildRootMenu(context);
      case _MobileMenuSection.shop:
        return _buildShopMenu(context);
      case _MobileMenuSection.printShack:
        return _buildPrintShackMenu(context);
    }
  }

  // ---------- ROOT LEVEL (like your screenshot) ----------
  List<Widget> _buildRootMenu(BuildContext context) {
    return [
      ListTile(
        title: const Text('Home'),
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        },
      ),
      const Divider(height: 1),

      // SHOP -> goes to second-level menu
      ListTile(
        title: const Text('Shop'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          setState(() {
            _section = _MobileMenuSection.shop;
          });
        },
      ),
      const Divider(height: 1),

      // PRINT SHACK -> second-level
      ListTile(
        title: const Text('The Print Shack'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          setState(() {
            _section = _MobileMenuSection.printShack;
          });
        },
      ),
      const Divider(height: 1),

      // SALE
      ListTile(
        title: const Text('SALE!'),
        onTap: () {
          Navigator.popAndPushNamed(context, '/sale');
        },
      ),
      const Divider(height: 1),

      // ABOUT
      ListTile(
        title: const Text('About'),
        onTap: () {
          Navigator.popAndPushNamed(context, '/about');
        },
      ),
      const Divider(height: 1),

      // UPSU.net (external) – you can hook this up with url_launcher later
      ListTile(
        title: const Text('UPSU.net'),
        onTap: () {
          // TODO: open https://upsu.net with url_launcher
        },
      ),
      const Divider(height: 1),
    ];
  }

  // ---------- SHOP SUBMENU ----------
  List<Widget> _buildShopMenu(BuildContext context) {
    return [
      ListTile(
        leading: const Icon(Icons.chevron_left),
        title: const Text('Shop'),
        onTap: () {
          setState(() {
            _section = _MobileMenuSection.root;
          });
        },
      ),
      const Divider(height: 1),
      ListTile(
        title: const Text('Clothing'),
        onTap: () {
          Navigator.popAndPushNamed(context, '/clothing');
        },
      ),
      const Divider(height: 1),
      ListTile(
        title: const Text('Merchandise'),
        onTap: () {
          Navigator.popAndPushNamed(context, '/merch');
        },
      ),
      const Divider(height: 1),
      ListTile(
        title: const Text('Halloween 🎃'),
        onTap: () {
          Navigator.popAndPushNamed(context, '/halloween');
        },
      ),
      const Divider(height: 1),
      ListTile(
        title: const Text('Signature & Essential Range'),
        onTap: () {
          Navigator.popAndPushNamed(context, '/signature');
        },
      ),
      const Divider(height: 1),
    ];
  }

  // ---------- PRINT SHACK SUBMENU ----------
  List<Widget> _buildPrintShackMenu(BuildContext context) {
    return [
      ListTile(
        leading: const Icon(Icons.chevron_left),
        title: const Text('The Print Shack'),
        onTap: () {
          setState(() {
            _section = _MobileMenuSection.root;
          });
        },
      ),
      const Divider(height: 1),
      ListTile(
        title: const Text('About the Print Shack'),
        onTap: () {
          Navigator.popAndPushNamed(context, '/print-shack');
        },
      ),
      const Divider(height: 1),
      ListTile(
        title: const Text('Personalisation'),
        onTap: () {
          Navigator.popAndPushNamed(context, '/print-shack-personalisation');
        },
      ),
      const Divider(height: 1),
    ];
  }
}
