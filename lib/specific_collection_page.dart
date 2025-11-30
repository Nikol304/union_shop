import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/widgets/product_card.dart';
import 'package:union_shop/models/product.dart';

class SpecificCollectionPage extends StatefulWidget {
  // Optional: use in your routes table
  static const routeName = '/collection';

  final String title;
  final String? subtitle;
  final List<Product> products;

  const SpecificCollectionPage({
    super.key,
    required this.title,
    this.subtitle,
    required this.products,
  });

  @override
  State<SpecificCollectionPage> createState() => _SpecificCollectionPageState();
}

class _SpecificCollectionPageState extends State<SpecificCollectionPage> {
  String _selectedFilter = 'All products';
  String _selectedSort = 'Featured';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 1100 ? 120 : (screenWidth > 800 ? 64 : 24);

    final products = widget.products; // TODO: apply filter/sort later
    final productCountLabel =
        '${products.length} product${products.length == 1 ? '' : 's'}';

    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// HERO SECTION (title + subtitle)
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                48,
                horizontalPadding,
                32,
              ),
              child: Column(
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if ((widget.subtitle ?? '').isNotEmpty)
                    Text(
                      widget.subtitle!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.black54,
                      ),
                    ),
                ],
              ),
            ),

            /// FILTER / SORT BAR
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300),
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Row(
                children: [
                  // Filter by
                  Row(
                    children: [
                      const Text(
                        'FILTER BY',
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _selectedFilter,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(
                            value: 'All products',
                            child: Text('All products'),
                          ),
                          DropdownMenuItem(
                            value: 'In stock',
                            child: Text('In stock'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => _selectedFilter = value);
                        },
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Sort by
                  Row(
                    children: [
                      const Text(
                        'SORT BY',
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _selectedSort,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(
                            value: 'Featured',
                            child: Text('Featured'),
                          ),
                          DropdownMenuItem(
                            value: 'Price: Low to High',
                            child: Text('Price: Low to High'),
                          ),
                          DropdownMenuItem(
                            value: 'Price: High to Low',
                            child: Text('Price: High to Low'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => _selectedSort = value);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(width: 16),

                  // Product count (e.g. "10 products")
                  Text(
                    productCountLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            /// PRODUCT GRID
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                32,
                horizontalPadding,
                40,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 1;
                  if (constraints.maxWidth >= 1100) {
                    crossAxisCount = 3;
                  } else if (constraints.maxWidth >= 700) {
                    crossAxisCount = 2;
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 32,
                      crossAxisSpacing: 32,
                      mainAxisExtent: 360, // adjust to your ProductCard height
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(product: product);
                    },
                  );
                },
              ),
            ),

            /// PAGINATION ROW (placeholder)
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: null, // hook up when you add pagination
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 24),
                  const Text('Page 1 of 1'),
                  const SizedBox(width: 24),
                  OutlinedButton(
                    onPressed: null,
                    child: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),

            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
