import 'package:flutter/material.dart';
import 'package:todo_app/module/todo.dart';
import 'package:todo_app/service/todo_db_service.dart';

class ToDoProvider extends ChangeNotifier {
  final ToDoDatabase database;
  List<ToDo> _todos = [];
  List<ToDo> foundToDos = [];

  List<ToDo> get todos => _todos;

  ToDoProvider(this.database);

  Future<void> loadTodos() async {
    _todos = await database.readAll();
    filterByDone(_todos);
    foundToDos = _todos;
    notifyListeners();
  }

  void filterByDone(List<ToDo> todoList) {
    List<ToDo> doneList = [];
    List<ToDo> undoList = [];
    for (var element in todoList) {
      if (element.isDone) {
        doneList.add(element);
      } else {
        undoList.add(element);
      }
    }
    todoList.clear();
    todoList.addAll(doneList);
    todoList.addAll(undoList);
  }

  Future<void> addTodo(ToDo todo) async {
    final newTodo = await database.create(todo);
    _todos.add(newTodo);
    notifyListeners();
  }

  Future<void> updateTodo(ToDo todo) async {
    await database.update(todo);
    final index = _todos.indexWhere((item) => item.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
      notifyListeners();
    }
  }

  Future onToDoStatusChange(ToDo todo)async{
    await updateTodo(todo);
    filterByDone(_todos);
    notifyListeners();
  }

  Future<void> deleteTodo(String id) async {
    await database.delete(id);
    _todos.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Future<void> deleteAll() async {
    await database.deleteAll();
    _todos = [];
    notifyListeners();
  }
}
