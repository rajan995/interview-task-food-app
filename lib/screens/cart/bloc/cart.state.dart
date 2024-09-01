import 'package:saler/model/cart.model.dart';
import 'package:saler/model/category.model.dart';
import 'package:saler/model/product.model.dart';

abstract class CartState {}

class InitialCartState extends CartState {}

class DataCartState extends CartState {
  List<Category>? categoryList;
  List<Product>? productList;
  String? selectedCategory;
  List<CartItem>? cartItems;

  DataCartState(
      {this.cartItems,
      this.categoryList,
      this.productList,
      this.selectedCategory});
  DataCartState copyWith(
      {List<Category>? categoryList,
      List<CartItem>? cartItems,
      List<Product>? productList,
      String? selectedCategory}) {
    return DataCartState(
        cartItems: cartItems ?? this.cartItems,
        categoryList: categoryList ?? this.categoryList,
        productList: productList,
        selectedCategory: selectedCategory);
  }
}
