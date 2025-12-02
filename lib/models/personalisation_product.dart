// lib/models/personalisation_product.dart
class PersonalisationProduct {
  final String id;
  final String title;
  final double price;
  final List<String> images; // asset paths for main + thumbnails
  final List<String> perLineOptions; // dropdown choices

  const PersonalisationProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.images,
    required this.perLineOptions,
  });
}
