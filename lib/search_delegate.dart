import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/product_catalog.dart';

class ProductSearchDelegate extends SearchDelegate {
  // Use the canonical catalog
  final List<Product> allProducts = kAllProducts;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = allProducts
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return const Center(child: Text("No products found"));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, i) {
        final product = results[i];
        return ListTile(
          leading: Image.asset(product.imageUrl, height: 50),
          title: Text(product.title),
          subtitle: Text('£${product.price}'),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/product',
              arguments: product,
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = allProducts
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, i) {
        final product = suggestions[i];
        return ListTile(
          title: Text(product.title),
          onTap: () {
            query = product.title;
            showResults(context);
          },
        );
      },
    );
  }
}
