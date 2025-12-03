import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/product', arguments: product),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // fixed image shape for all cards — use a wider image so cards are less tall
          AspectRatio(
            aspectRatio: 4 / 3,
            child: _ProductImage(imageUrl: product.imageUrl),
          ),
          const SizedBox(height: 12),
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

class _ProductImage extends StatelessWidget {
  final String imageUrl;

  const _ProductImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final bool isNetwork = imageUrl.startsWith('http');

    final Widget image = isNetwork
        ? Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _buildFallback(),
          )
        : Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _buildFallback(),
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: image,
    );
  }

  Widget _buildFallback() {
    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.image_not_supported, color: Colors.grey),
      ),
    );
  }
}
