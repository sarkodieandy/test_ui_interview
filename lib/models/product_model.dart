class Product {
  final int id;
  final String title;
  final String thumbnail;
  final double price;
  final double rating;
  bool isFavorite;
  final bool isTrending;
  final bool isTopRated;

  Product({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.rating,
    this.isFavorite = false,
    this.isTrending = false,
    this.isTopRated = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      // Simulate badges for fun
      isTrending: json['id'] % 3 == 0,
      isTopRated: json['rating'] != null && json['rating'] > 4.5,
    );
  }
}
