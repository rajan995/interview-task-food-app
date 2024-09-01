import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saler/model/_dummydate/_dummydata.dart';
import 'package:saler/model/cart.model.dart';
import 'package:saler/model/category.model.dart';
import 'package:saler/model/product.model.dart';
import 'package:saler/model/product.model.dart';
import 'package:saler/screens/cart/bloc/cart.bloc.dart';
import 'package:saler/screens/cart/bloc/cart.event.dart';
import 'package:saler/screens/cart/bloc/cart.state.dart';

class CartScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: Column(
          children: [
            Expanded(child: CartItemWidget()),
            Expanded(child: CategoryWidget()),
            ElevatedButton(onPressed: () {}, child: Text("Order Now"))
          ],
        ));
  }

  Widget CartItemWidget() {
    return BlocBuilder<CartBloc, CartState>(builder: (context, snapshot) {
      if (snapshot is DataCartState && snapshot.cartItems != null) {
        List<CartItem> productList = snapshot.cartItems!;

        return ListView(
          children: [
            ...productList.map((e) => ListTile(
                  title: Text(e.itemName),
                  subtitle: Text("Qty: ${e.itemQty}"),
                  trailing: Text("\$" + e.price!.toString()),
                )),
            ListTile(
              title: Text("Total Price"),
              trailing: Text("\$" +
                  productList
                      .fold<double>(0.0, (t, e) => t + e.price! * e.itemQty!)
                      .toString()),
            )
          ],
        );
      }
      return Center(
        child: Container(),
      );
    });
  }

  Widget CategoryWidget() {
    return BlocBuilder<CartBloc, CartState>(builder: (context, snapshot) {
      if (snapshot is DataCartState && snapshot.productList != null) {
        List<Product> productList = snapshot.productList!;
        return ProductWidget(productList, context, snapshot.selectedCategory!);
      }
      if (snapshot is DataCartState && snapshot.categoryList != null) {
        List<Category> categoryList = snapshot.categoryList!;
        return Container(
          child: ListView.builder(
              itemCount: categoryList.length,
              itemBuilder: (builder, i) => InkWell(
                    onTap: () {
                      context.read<CartBloc>().add(SelectedCategoryEvent(
                          categoryName: categoryList[i].name));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Text(categoryList[i].name),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                    ),
                  )),
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  Widget ProductWidget(List<Product> productList, BuildContext context,
      String selectedCategory) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  context.read<CartBloc>().add(ProductBackCartEvent());
                },
                icon: Icon(Icons.arrow_back)),
            Text(selectedCategory)
          ],
        ),
        Expanded(
          child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (builder, i) => InkWell(
                    onTap: () {
                      context
                          .read<CartBloc>()
                          .add(AddIteminCart(product: productList[i]));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: ListTile(
                        title: Text(productList[i].name),
                        subtitle: Text(productList[i].category),
                        trailing: Text("\$ ${productList[i].price}"),
                      ),
                    ),
                  )),
        ),
      ],
    );
  }
}
