class Cart {
  int? id;
  int? totalPrice;
  DateTime? date;
  Cart({this.id, this.totalPrice, this.date});
  factory Cart.fromJson(Map<String, dynamic> map) {
    int? id = map['id'];
    int? totalPrice = map['totalPrice'] == "null" ? null : map['totalPrice'];
    DateTime? date = DateTime.tryParse(map['date']);
    print("");
    return Cart(id: id, totalPrice: totalPrice);
  }
}

class CartItem {
  int? id;
  int cartId;
  String itemName;
  int itemQty;
  double? price;
  CartItem(
      {required this.cartId,
      this.id,
      required this.itemName,
      required this.itemQty,
      required this.price});
  factory CartItem.fromJson(Map<String, dynamic> map) {
    return CartItem(
        cartId: map['cartId'] == 'null' ? null : map['cartId'],
        id: map['id'],
        itemName: map['itemName'],
        itemQty: map['itemQty'] == 'null' ? null : map['itemQty'],
        price: double.tryParse(map['price'].toString()));
  }
}
