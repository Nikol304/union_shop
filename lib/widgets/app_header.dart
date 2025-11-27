import 'package:flutter/material.dart';
import 'package:union_shop/widgets/shop_nav_dropdown.dart';
import 'package:union_shop/widgets/print_shack_nav_dropdown.dart';

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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF4d2963),
            child: const Text(
              'PLACEHOLDER HEADER TEXT',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: navigateToHome,
                    child: Image.network(
                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                      height: 18,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          width: 18,
                          height: 18,
                          child: const Center(
                            child: Icon(Icons.image_not_supported,
                                color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 32),
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
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                          onPressed: () {},
                        ),
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
                          onPressed: () {},
                        ),
                        PopupMenuButton<String>(
                          icon: const Icon(
                            Icons.menu,
                            size: 18,
                            color: Colors.grey,
                          ),
                          onSelected: (value) {
                            switch (value) {
                              case 'home':
                                navigateToHome();
                                break;
                              case 'products':
                                navigateTo('/product');
                                break;
                              case 'sale':
                                navigateTo('/sale');
                                break;
                              case 'collections':
                                navigateTo('/collections');
                                break;
                              case 'about':
                                navigateTo('/about');
                                break;
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(value: 'home', child: Text('Home')),
                            PopupMenuItem(
                                value: 'products', child: Text('Products')),
                            PopupMenuItem(value: 'sale', child: Text('Sale')),
                            PopupMenuItem(
                                value: 'collections',
                                child: Text('Collections')),
                            PopupMenuItem(value: 'about', child: Text('About')),
                          ],
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
