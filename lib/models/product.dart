class Product {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  // New optional fields
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
    this.description = '',
    this.category = '',
    this.collection = '',
    this.inStock = true,
    this.isOnSale = false,
  });

  // Backwards compatibility: some code still uses `name`.
  String get name => title;
}
