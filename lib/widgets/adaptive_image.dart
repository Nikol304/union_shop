import 'package:flutter/material.dart';

/// AdaptiveImage renders either a network image (if the path starts with
/// 'http') or an asset image otherwise. It provides an errorBuilder so the
/// UI shows a placeholder when loading fails.
class AdaptiveImage extends StatelessWidget {
  final String path;
  final BoxFit fit;
  final double? width;
  final double? height;

  const AdaptiveImage(
    this.path, {
    super.key,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (c, e, s) => _errorWidget(),
      );
    }

    return Image.asset(
      path,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (c, e, s) => _errorWidget(),
    );
  }

  Widget _errorWidget() => Container(
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        child: const Icon(Icons.broken_image, color: Colors.grey),
      );
}
