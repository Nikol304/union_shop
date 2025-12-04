import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart_model.dart';
import 'package:union_shop/widgets/shop_nav_dropdown.dart';
import 'package:union_shop/widgets/print_shack_nav_dropdown.dart';
import 'package:union_shop/widgets/adaptive_image.dart';
import 'package:union_shop/search_delegate.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  const AppHeader({Key? key}) : super(key: key);

  @override
  State<AppHeader> createState() => _AppHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _AppHeaderState extends State<AppHeader> {
  final TextEditingController _searchController = TextEditingController();
  bool _showSearch = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _submitSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _showSearch = false;
    });

    showSearch(
      context: context,
      delegate: ProductSearchDelegate(),
      query: query,
    );
  }

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
      height: widget.preferredSize.height,
      color: Colors.white,
      child: Column(
        children: [
          // TOP BANNER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
            color: const Color(0xFF4d2963),
            child: const Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),

          // MOBILE SEARCH ROW: only when search is active on mobile
          if (isMobile && _showSearch) _buildMobileSearchRow(),

          // MAIN HEADER ROW:
          // - always shown on desktop
          // - hidden on mobile *while* search row is visible
          if (!isMobile || !_showSearch)
            Expanded(
              child: _buildMainHeaderRow(
                context: context,
                isMobile: isMobile,
                navigateTo: navigateTo,
                navigateToHome: navigateToHome,
              ),
            ),
        ],
      ),
    );
  }

  /// Normal header row (logo + nav + icons)
  Widget _buildMainHeaderRow({
    required BuildContext context,
    required bool isMobile,
    required void Function(String route) navigateTo,
    required VoidCallback navigateToHome,
  }) {
    return Container(
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

          // RIGHT SIDE ICONS (search / inline search, user, cart, burger)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // DESKTOP INLINE SEARCH BAR
              if (!isMobile && _showSearch) ...[
                SizedBox(
                  width: 220,
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (_) => _submitSearch(),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.search,
                          size: 18,
                          color: Colors.grey,
                        ),
                        onPressed: _submitSearch,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.grey,
                  ),
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  onPressed: () {
                    setState(() {
                      _showSearch = false;
                    });
                  },
                ),
              ] else ...[
                // SEARCH ICON (desktop toggles inline, mobile shows top search row)
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
                    if (isMobile) {
                      setState(() {
                        _showSearch =
                            true; // show top search row, hide header row
                      });
                    } else {
                      setState(() {
                        _showSearch = true; // show inline search
                      });
                    }
                  },
                ),
              ],

              // These icons stay visible on DESKTOP, even when inline search is open
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
                  Navigator.pushNamed(context, '/login');
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
        ],
      ),
    );
  }

  /// Mobile-only full-width search row (like your screenshot)
  Widget _buildMobileSearchRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 36,
              child: TextField(
                controller: _searchController,
                style: const TextStyle(fontSize: 14),
                onSubmitted: (_) => _submitSearch(),
                decoration: InputDecoration(
                  hintText: 'Search',
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  suffixIcon: IconButton(
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(
                      minWidth: 28,
                      minHeight: 28,
                    ),
                    icon: const Icon(
                      Icons.search,
                      size: 18,
                      color: Colors.grey,
                    ),
                    onPressed: _submitSearch,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            padding: const EdgeInsets.all(6),
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
            icon: const Icon(
              Icons.close,
              size: 18,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _showSearch = false;
              });
            },
          ),
        ],
      ),
    );
  }
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
  final TextEditingController _mobileSearchController = TextEditingController();
  bool _showMobileSearch = false;

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
                  if (_showMobileSearch) ...[
                    SizedBox(
                      width: isMobile ? 180 : 220,
                      child: TextField(
                        controller: _mobileSearchController,
                        onSubmitted: (_) {
                          final q = _mobileSearchController.text.trim();
                          if (q.isEmpty) return;
                          setState(() => _showMobileSearch = false);
                          showSearch(
                            context: context,
                            delegate: ProductSearchDelegate(),
                            query: q,
                          );
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _showMobileSearch = false;
                        });
                      },
                    ),
                  ] else ...[
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 18,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _showMobileSearch = true;
                        });
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
