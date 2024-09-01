import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saler/model/_dummydate/_dummydata.dart';
import 'package:saler/model/cart.model.dart';
import 'package:saler/model/category.model.dart';
import 'package:saler/model/product.model.dart';
import 'package:saler/repository/sqlite.dart';
import 'package:saler/screens/cart/bloc/cart.event.dart';
import 'package:saler/screens/cart/bloc/cart.state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  DataCartState? cartState = DataCartState();
  SqliteDBRepository db;
  Cart? cart;
  List<CartItem>? cartItem;
  CartBloc({required this.db, this.cart}) : super(InitialCartState()) {
    on<InitialCartEvent>(
      (event, emit) async {
        if (cart != null) {
          cartItem = await db.getCartsItems(cart!.id!);
          print(cartItem);
        }
        List<Category>? categoryList =
            dummyCategory.map((e) => Category.fromJson(e)).toList();

        cartState = cartState!
            .copyWith(cartItems: cartItem, categoryList: categoryList);
        emit(cartState!);
      },
    );
    on<SelectedCategoryEvent>(
      (event, emit) {
        List<Product>? productList = dummyProduct
            .map((e) => Product.fromJson(e))
            .where((product) => product.category == event.categoryName)
            .toList();
        cartState = cartState!.copyWith(
            productList: productList!, selectedCategory: event.categoryName);
        emit(cartState!);
      },
    );
    on<ProductBackCartEvent>(
      (event, emit) {
        cartState =
            cartState!.copyWith(productList: null, selectedCategory: null);
        emit(cartState!);
      },
    );
    on<AddIteminCart>(
      (event, emit) async {
        Product product = event.product;
        if (cart == null) {
          int? id = await db.createCart(Cart());
          if (id != null) {
            cart = Cart(id: id);
            cartItem = [];
          }
        }

        CartItem? findItem = cartItem == null
            ? null
            : cartItem!.cast<CartItem?>().firstWhere(
                  (d) => d!.itemName == product.name,
                  orElse: () => null,
                );
        print(findItem);
        if (findItem != null) {
          CartItem item = findItem;

          cartItem!.map((d) {
            if (d.itemName == item.itemName) {
              CartItem updateCartItem = d;
              updateCartItem.itemQty = updateCartItem.itemQty + 1;
              db.updateCartItemQty(updateCartItem);
              return updateCartItem;
            } else {
              return d;
            }
          }).toList();
        } else {
          CartItem newCartItem = CartItem(
              cartId: cart!.id!,
              itemName: product.name,
              itemQty: 1,
              price: product.price);

          int? id = await db.addItemCart(newCartItem);
          if (id != null) {
            newCartItem.id = id;
          }

          cartItem!.add(newCartItem);
        }
        cartState = cartState!.copyWith(cartItems: cartItem);
        emit(cartState!);
      },
    );
  }
}
