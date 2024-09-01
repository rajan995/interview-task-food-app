import 'package:saler/model/cart.model.dart';

abstract class TableState {}

class InitialTableState extends TableState {}

class DataTableState extends TableState {
  List<Cart>? cartList;
  DataTableState({this.cartList});
  DataTableState copyWith({List<Cart>? cartList}) {
    return DataTableState(cartList: cartList ?? this.cartList);
  }
}
