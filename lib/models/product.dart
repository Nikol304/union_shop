class Product {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  // New optional fields
  /// Optional old price for sales/discounts
  final double? oldPrice;

  /// Extra images for the gallery (thumbnails). Keep default empty so existing
  /// Product(...) constructions remain compatible.
  final List<String> galleryImages;

  final String description;
  final String category; // e.g. 'clothing', 'merch'
  final String collection; // e.g. 'essential', 'signature', 'halloween'
  final bool inStock;
  final bool isOnSale;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.oldPrice,
    this.galleryImages = const [],
    this.description = '',
    this.category = '',
    this.collection = '',
    this.inStock = true,
    this.isOnSale = false,
  });

  // Backwards compatibility: some code still uses `name`.
  String get name => title;
}
