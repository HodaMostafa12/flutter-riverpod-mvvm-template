import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/remote/sql_client.dart';
import 'model/todo_response.dart';

final taskRepoProvider = Provider<TodoRepo>((ref) {
  final database = ref.watch(sqlClientProvider); // احصل على قاعدة البيانات
  return TodoRepo(database); // أنشئ كائن TodoRepo باستخدام قاعدة البيانات
});
class TodoRepo {
  SQFClient sqfClient;
  TodoRepo(this.sqfClient);

  // هذه الدالة لاسترجاع جميع todos من قاعدة البيانات
  Future<List<Todo>> getAllTodos() async {
    Database db = await sqfClient.database;
    final result = await db.query('todos');
    return result.map((json) => Todo.fromMap(json)).toList();
  }

  // دالة لإضافة Todo جديد إلى قاعدة البيانات
  Future<int> addTodo(Todo todo) async {
    Database db = await sqfClient.database;
    return await db.insert('todos', todo.toMap());
  }

  // دالة لتحديث Todo موجود
  Future<int> updateTodo(Todo todo) async {
    Database db = await sqfClient.database;
    return await db
        .update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  // دالة لحذف Todo بواسطة ID
  Future<int> deleteToDoById(int id) async {
    Database db = await sqfClient.database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
