import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/product'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.title,
            style: const TextStyle(fontSize: 14, color: Colors.black),
            maxLines: 2,
          ),
          const SizedBox(height: 4),
          Text(
            '£${product.price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
