import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/adaptive_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/product', arguments: product),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area expands to fill available space inside a square grid tile.
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AdaptiveImage(
                product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.title,
            style: const TextStyle(fontSize: 14, color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          _buildPriceRow(product),
        ],
      ),
    );
  }

  Widget _buildPriceRow(Product product) {
    if (product.oldPrice != null && product.oldPrice! > product.price) {
      return Row(
        children: [
          Text(
            '£${product.oldPrice!.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '£${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      );
    }

    return Text(
      '£${product.price.toStringAsFixed(2)}',
      style: const TextStyle(fontSize: 13, color: Colors.grey),
    );
  }
}
