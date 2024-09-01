import 'package:saler/model/product.model.dart';

abstract class CartEvent {}

class InitialCartEvent extends CartEvent {}

class SelectedCategoryEvent extends CartEvent {
  String categoryName;
  SelectedCategoryEvent({required this.categoryName});
}

class ProductBackCartEvent extends CartEvent {}

class AddIteminCart extends CartEvent {
  Product product;
  AddIteminCart({required this.product});
}

class RemoveIteminCart extends CartEvent {
  Product product;
  RemoveIteminCart({required this.product});
}
