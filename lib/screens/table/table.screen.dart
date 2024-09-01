import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saler/model/cart.model.dart';
import 'package:saler/screens/table/bloc/table.bloc.dart';
import 'package:saler/screens/table/bloc/table.event.dart';
import 'package:saler/screens/table/bloc/table.state.dart';

class TableScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cart Table Data"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed("/cart", arguments: null)
              .then((onValue) {
            context.read<TableBloc>().add(InitialTableEvent());
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 18,
        ),
      ),
      body: BlocBuilder<TableBloc, TableState>(builder: (context, snapshot) {
        if (snapshot is DataTableState && snapshot.cartList != null) {
          List<Cart> cartList = snapshot.cartList!;
          return ListView.builder(
            itemCount: cartList.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed("/cart", arguments: cartList[i])
                      .then((d) {
                    context.read<TableBloc>().add(InitialTableEvent());
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: ListTile(
                    title: Text("Cart Table Id ${cartList[i].id}"),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
