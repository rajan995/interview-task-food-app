class Product {
  int? id;
  String name;
  String category;
  double price;
  Product(
      {this.id,
      required this.name,
      required this.price,
      required this.category});
  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
        id: map['id'],
        name: map['name'],
        price: map['price'],
        category: map['category']);
  }
}
