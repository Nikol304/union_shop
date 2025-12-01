import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/widgets/product_card.dart';

class SpecificCollectionPage extends StatefulWidget {
  final String title;
  final List<Product> products;

  const SpecificCollectionPage({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  State<SpecificCollectionPage> createState() => _SpecificCollectionPageState();
}

class _SpecificCollectionPageState extends State<SpecificCollectionPage> {
  String _selectedFilter = 'all';
  String _selectedSort = 'featured';

  int _currentPage = 0;
  static const int _itemsPerPage = 6;

  List<Product> get _filteredAndSorted {
    List<Product> list = List<Product>.from(widget.products);

    // FILTER
    switch (_selectedFilter) {
      case 'inStock':
        list = list.where((p) => p.inStock).toList();
        break;
      case 'onSale':
        list = list.where((p) => p.isOnSale).toList();
        break;
      case 'clothing':
        list = list.where((p) => p.category == 'clothing').toList();
        break;
      case 'merch':
        list = list.where((p) => p.category == 'merch').toList();
        break;
      case 'all':
      default:
        break;
    }

    // SORT
    switch (_selectedSort) {
      case 'priceLowHigh':
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'priceHighLow':
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'nameAZ':
        list.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'nameZA':
        list.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 'featured':
      default:
        break;
    }

    return list;
  }

  void _onFilterChanged(String? value) {
    if (value == null) return;
    setState(() {
      _selectedFilter = value;
      _currentPage = 0;
    });
  }

  void _onSortChanged(String? value) {
    if (value == null) return;
    setState(() {
      _selectedSort = value;
      _currentPage = 0;
    });
  }

  void _goToPreviousPage(int totalPages) {
    if (_currentPage == 0) return;
    setState(() {
      _currentPage = (_currentPage - 1).clamp(0, totalPages - 1);
    });
  }

  void _goToNextPage(int totalPages) {
    setState(() {
      _currentPage =
          (_currentPage + 1).clamp(0, totalPages == 0 ? 0 : totalPages - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredAndSorted;

    int totalPages = (filtered.length / _itemsPerPage).ceil();
    if (totalPages == 0) totalPages = 1;

    if (_currentPage > totalPages - 1) {
      _currentPage = totalPages - 1;
    }

    final int startIndex = _currentPage * _itemsPerPage;
    final int endIndex = (startIndex + _itemsPerPage).clamp(0, filtered.length);
    final List<Product> pageItems =
        filtered.isEmpty ? [] : filtered.sublist(startIndex, endIndex);

    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 48,
                  vertical: isMobile ? 16 : 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Collection: ${widget.title}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${filtered.length} products',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),

                    // Filter + Sort
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Filter by:',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 8),
                            DropdownButton<String>(
                              value: _selectedFilter,
                              onChanged: _onFilterChanged,
                              items: const [
                                DropdownMenuItem(
                                  value: 'all',
                                  child: Text('All products'),
                                ),
                                DropdownMenuItem(
                                  value: 'inStock',
                                  child: Text('In stock'),
                                ),
                                DropdownMenuItem(
                                  value: 'onSale',
                                  child: Text('On sale'),
                                ),
                                DropdownMenuItem(
                                  value: 'clothing',
                                  child: Text('Clothing only'),
                                ),
                                DropdownMenuItem(
                                  value: 'merch',
                                  child: Text('Merch only'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Sort by:',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 8),
                            DropdownButton<String>(
                              value: _selectedSort,
                              onChanged: _onSortChanged,
                              items: const [
                                DropdownMenuItem(
                                  value: 'featured',
                                  child: Text('Featured'),
                                ),
                                DropdownMenuItem(
                                  value: 'priceLowHigh',
                                  child: Text('Price: Low to High'),
                                ),
                                DropdownMenuItem(
                                  value: 'priceHighLow',
                                  child: Text('Price: High to Low'),
                                ),
                                DropdownMenuItem(
                                  value: 'nameAZ',
                                  child: Text('Name: A–Z'),
                                ),
                                DropdownMenuItem(
                                  value: 'nameZA',
                                  child: Text('Name: Z–A'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Grid of products
                    if (pageItems.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 32),
                          child: Text('No products match your filters.'),
                        ),
                      )
                    else
                      LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount = 3;
                          final width = constraints.maxWidth;
                          if (width < 600) {
                            crossAxisCount = 1;
                          } else if (width < 900) {
                            crossAxisCount = 2;
                          }
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: 24,
                              crossAxisSpacing: 24,
                              childAspectRatio: 0.72,
                            ),
                            itemCount: pageItems.length,
                            itemBuilder: (context, index) {
                              final product = pageItems[index];
                              return ProductCard(product: product);
                            },
                          );
                        },
                      ),

                    const SizedBox(height: 24),

                    // Pagination controls
                    if (filtered.length > _itemsPerPage)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: _currentPage > 0
                                ? () => _goToPreviousPage(totalPages)
                                : null,
                            child: const Text('Previous'),
                          ),
                          const SizedBox(width: 16),
                          Text('Page ${_currentPage + 1} of $totalPages'),
                          const SizedBox(width: 16),
                          TextButton(
                            onPressed: _currentPage < totalPages - 1
                                ? () => _goToNextPage(totalPages)
                                : null,
                            child: const Text('Next'),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }
}
