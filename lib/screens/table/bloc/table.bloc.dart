import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saler/model/cart.model.dart';
import 'package:saler/repository/sqlite.dart';
import 'package:saler/screens/table/bloc/table.event.dart';
import 'package:saler/screens/table/bloc/table.state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  SqliteDBRepository db;
  DataTableState tableState = DataTableState();
  TableBloc({required this.db}) : super(InitialTableState()) {
    on<InitialTableEvent>((event, emit) async {
      List<Cart> cartList = await db.getCarts();
      tableState = tableState.copyWith(cartList: cartList);
      emit(tableState);
    });
  }
}
