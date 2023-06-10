import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/module/todo.dart';

class ToDoDatabase {
  static final ToDoDatabase instance = ToDoDatabase._init();

  static Database? _database;

  ToDoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id TEXT PRIMARY KEY,
        todoText TEXT,
        isDone INTEGER
      )
    ''');
  }

  Future<ToDo> create(ToDo todo) async {
    final db = await instance.database;
    final id = await db.insert('todos', todo.toJson());
    return todo.copy(id: id.toString());
  }

  Future<ToDo> read(String id) async {
    final db = await instance.database;
    final maps = await db.query('todos', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return ToDo.fromJson(maps.first);
    } else {
      throw Exception('Todo not found!');
    }
  }

  Future<List<ToDo>> readAll() async {
    final db = await instance.database;
    final result = await db.query('todos');

    return result.map((json) => ToDo.fromJson(json)).toList();
  }

  Future<void> update(ToDo todo) async {
    final db = await instance.database;
    await db.update(
      'todos',
      todo.toJson(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await instance.database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    final db = await instance.database;
    await db.delete('todos');
  }
}
