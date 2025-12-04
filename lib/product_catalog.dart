import 'package:union_shop/models/product.dart';

// Canonical product catalog used for search. This is a simple, hand-curated
// list composed from the product declarations across the app. Keep it small
// and expand over time or generate it from your backend/data source.

const List<Product> kAllProducts = [
  // Home / Essentials
  Product(
    id: 'essential-zip-hoodie',
    title: 'Limited Edition Essential Zip Hoodies',
    price: 14.99,
    oldPrice: 20.00,
    imageUrl: 'assets/images/sweatshirt_grey.png',
  ),
  Product(
    id: 'essential-tshirt',
    title: 'Essential T-Shirt',
    price: 6.99,
    oldPrice: 10.00,
    imageUrl: 'assets/images/tshirts.png',
  ),

  // Signature
  Product(
    id: 'signature-hoodie',
    title: 'Signature Hoodie',
    price: 32.99,
    imageUrl: 'assets/images/hoodie_green.png',
  ),
  Product(
    id: 'signature-tshirt',
    title: 'Signature T-Shirt',
    price: 14.99,
    imageUrl: 'assets/images/tshirts.png',
  ),

  // Portsmouth City range
  Product(
    id: 'portsmouth-postcard',
    title: 'Portsmouth City Postcard',
    price: 1.00,
    imageUrl: 'assets/images/postcard.png',
  ),
  Product(
    id: 'portsmouth-magnet',
    title: 'Portsmouth City Magnet',
    price: 4.50,
    imageUrl: 'assets/images/magnet.png',
  ),
  Product(
    id: 'portsmouth-badge',
    title: 'Portsmouth City Badge',
    price: 3.50,
    imageUrl: 'assets/images/badge.png',
  ),
  Product(
    id: 'portsmouth-notebook',
    title: 'Portsmouth City Notebook',
    price: 6.00,
    imageUrl: 'assets/images/notebook.png',
  ),
  Product(
    id: 'portsmouth-crystal-ball',
    title: 'Portsmouth City Crystal Ball',
    price: 6.00,
    imageUrl: 'assets/images/crystal_ball.png',
  ),
  Product(
    id: 'portsmouth-bookmark',
    title: 'Portsmouth City Book Mark',
    price: 6.00,
    imageUrl: 'assets/images/bookmark.png',
  ),

  // Clothing
  Product(
    id: 'classic-hoodies',
    title: 'Classic Hoodies',
    price: 25.00,
    imageUrl: 'assets/images/hoodie_grey.png',
  ),
  Product(
    id: 'classic-sweatshirts',
    title: 'Classic Sweatshirts',
    price: 23.00,
    imageUrl: 'assets/images/hoodie_red.png',
  ),
  Product(
    id: 'classic-tshirts',
    title: 'Classic T-Shirts',
    price: 15.00,
    imageUrl: 'assets/images/classic_tshirt.png',
  ),

  // Merch
  Product(
    id: 'union-tote-bag',
    title: 'Union Tote Bag',
    price: 8.00,
    imageUrl: 'assets/images/tote_bag.png',
  ),
  Product(
    id: 'union-mug',
    title: 'Union Mug',
    price: 6.00,
    imageUrl: 'assets/images/mug.png',
  ),

  // Sale samples
  Product(
    id: 'sale-a5-notepad',
    title: 'A5 Notepad',
    price: 1.80,
    oldPrice: 3.00,
    imageUrl:
        'https://images.pexels.com/photos/950241/pexels-photo-950241.jpeg',
  ),
  Product(
    id: 'sale-classic-sweatshirt-neutral',
    title: 'Classic Sweatshirts - Neutral',
    price: 10.99,
    oldPrice: 17.00,
    imageUrl:
        'https://images.pexels.com/photos/7671166/pexels-photo-7671166.jpeg',
  ),

  // Halloween
  Product(
    id: 'halloween-tote',
    title: 'Halloween Tote Bags',
    price: 2.50,
    imageUrl: 'assets/images/Halloween_bag.png',
  ),
];
