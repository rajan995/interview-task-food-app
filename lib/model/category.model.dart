class Category {
  int? id;
  String name;
  Category({this.id, required this.name});
  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(name: map['name'], id: map['id']);
  }
}
