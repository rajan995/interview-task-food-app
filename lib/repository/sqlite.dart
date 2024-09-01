import 'package:path/path.dart';
import 'package:saler/model/cart.model.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDBRepository {
  Future<String> getDbPath() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cart.db');
    return path;
  }

  Future<Database> createTableIfNotExist() async {
    String path = await getDbPath();
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Cart (id INTEGER PRIMARY KEY, totalPrice INTEGER, date TEXT )');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS CartItem (id INTEGER PRIMARY KEY, cartId INTEGER, itemName TEXT, itemQty INTEGER, price INTEGER )');
    });
    return database;
  }

  Future<int?> createCart(Cart cartModel) async {
    final database = await createTableIfNotExist();
    int? id;
    await database.transaction((txn) async {
      id = await txn.rawInsert(
          "INSERT INTO Cart(totalPrice, date) VALUES ('${cartModel.totalPrice}', '${cartModel.date}')");
    });
    await database.close();
    return id;
  }

  Future<List<Cart>> getCarts() async {
    final database = await createTableIfNotExist();
    List<Map> list = await database.rawQuery("SELECT * FROM Cart");
    List<Cart> carts = list
        .cast<Map<String, dynamic>>()
        .map<Cart>((e) => Cart.fromJson(e))
        .toList();
    await database.close();
    return carts;
  }

  Future<int?> addItemCart(CartItem cardItem) async {
    final database = await createTableIfNotExist();
    int? id;
    await database.transaction((txn) async {
      id = await txn.rawInsert(
          "INSERT INTO CartItem(cartId, itemName, itemQty, price) VALUES ('${cardItem.cartId}', '${cardItem.itemName}', '${cardItem.itemQty}', '${cardItem.price}')");
    });
    await database.close();
    return id;
  }

  Future<List<CartItem>> getCartsItems(int cartId) async {
    final database = await createTableIfNotExist();
    List<Map> list = await database
        .rawQuery("SELECT * FROM CartItem WHERE cartId == ${cartId}");
    List<CartItem> cartItem = list
        .cast<Map<String, dynamic>>()
        .map<CartItem>((e) => CartItem.fromJson(e))
        .toList();
    await database.close();
    return cartItem;
  }

  Future<int?> updateCartItemQty(CartItem item) async {
    final database = await createTableIfNotExist();

    int count = await database
        .rawUpdate("UPDATE CartItem SET itemQty = ?  WHERE id = '${item.id}'", [
      item.itemQty,
    ]);
    await database.close();
    return count;
  }
}
  // Future<int?> updateTodo(TodoModel todoModel) async {
  //   final database = await createToDoTableIfNotExist();

  //   int count = await database.rawUpdate(
  //       "UPDATE Todo SET title = ?, description = ?, dueDate = ?, complete = ?, priorityLevel = ?, fireStoreId = ?, localDelete = ?  WHERE id = '${todoModel.id}'",
  //       [
  //         todoModel.title,
  //         todoModel.description,
  //         todoModel.dueDate,
  //         todoModel.complete.toString(),
  //         todoModel.priorityLevel,
  //         todoModel.fireStoreId,
  //         todoModel.localDelete.toString()
  //       ]);
  //   await database.close();
  //   return count;
  // }

  // Future<int?> deleteTodo(TodoModel todoModel) async {
  //   final database = await createToDoTableIfNotExist();
  //   final count = await database
  //       .rawDelete('DELETE FROM Todo WHERE id = ?', [todoModel.id]);

  //   await database.close();
  //   return count;
  // }

  // Future<List<TodoModel>> getTodos() async {
  //   final database = await createToDoTableIfNotExist();
  //   List<Map> list = await database.rawQuery("SELECT * FROM Todo");

  //   List<TodoModel> todoModelList = list
  //       .cast<Map<String, dynamic>>()
  //       .map<TodoModel>((d) => TodoModel.fromJson(d))
  //       .toList();
  //   print(todoModelList);
  //   await database.close();
  //   return todoModelList;
  // }

