import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saler/model/cart.model.dart';
import 'package:saler/repository/sqlite.dart';
import 'package:saler/screens/cart/bloc/cart.bloc.dart';
import 'package:saler/screens/cart/bloc/cart.event.dart';
import 'package:saler/screens/cart/cart.screen.dart';
import 'package:saler/screens/table/bloc/table.bloc.dart';
import 'package:saler/screens/table/bloc/table.event.dart';
import 'package:saler/screens/table/table.screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
          builder: (context) => BlocProvider<TableBloc>(
              create: (context) =>
                  TableBloc(db: context.read<SqliteDBRepository>())
                    ..add(InitialTableEvent()),
              child: TableScreen()));
    case '/cart':
      return MaterialPageRoute(
          builder: (_) => BlocProvider<CartBloc>(
              create: (context) => CartBloc(
                  cart: settings.arguments as Cart?,
                  db: context.read<SqliteDBRepository>())
                ..add(InitialCartEvent()),
              child: CartScreen()));
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}
