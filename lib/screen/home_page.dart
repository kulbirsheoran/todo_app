import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constant/color_const.dart';
import 'package:todo_app/constant/path_constant.dart';
import 'package:todo_app/constant/routes_const.dart';
import 'package:todo_app/constant/string_constants.dart';
import 'package:todo_app/module/todo.dart';
import 'package:todo_app/provider/todo_provider.dart';

import 'package:todo_app/screen/todo_item.dart';
import 'package:todo_app/service/todo_db_service.dart';
import 'package:todo_app/widget/search_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoController = TextEditingController();
  late ToDoProvider toDoProvider;

  @override
  void initState() {
    toDoProvider = ToDoProvider(ToDoDatabase.instance);
    fetchTodo();
    super.initState();
  }

  fetchTodo() async {
    try {
       await toDoProvider.loadTodos();
      setState(() {});
    } catch (e) {
      print('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ToDoProvider>(
      create: (context) => toDoProvider,
      child: Scaffold(
        drawer: Drawer(
          child: Center(
            child: InkWell(
              child: const Text(StringConstant.logoutHomePage),
              onTap: () {
                toDoProvider.deleteAll();
                Navigator.pushReplacementNamed(context, Routes.loginScreen);
              },
            ),
          ),
        ),
        backgroundColor: Colors.greenAccent,
        appBar: buildAppBar(),
        body: Consumer<ToDoProvider>(
          builder: (context,provider,child){
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    children: [
                      SearchWidget((value){
                        runFilter(value);
                      }),
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 50, bottom: 20),
                                child: const Text(
                                  StringConstant.allToDoTextHomePage,
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                )),
                            for (ToDo todos in provider.foundToDos.reversed)
                              ToDoItem(
                                toDo: todos,
                                onToDoChanged: handleToDoChange,
                                onDeleteItem: deleteToDoItem,
                              ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 10.0,
                                          offset: Offset(0.0, 0.0),
                                          color: tdGrey),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: TextField(
                                    controller: todoController,
                                    decoration: const InputDecoration(
                                        hintText: StringConstant.newAddTodoHomePage,
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: InkWell(
                                  onTap: () {
                                    addToDoItem(todoController.text);
                                  },
                                  child: const Text(
                                    StringConstant.addIconHomePage,
                                    style: TextStyle(color: Colors.white, fontSize: 40),
                                  ),
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void deleteToDoItem(String id) {
    toDoProvider.deleteTodo(id);
  }

  void addToDoItem(String data) {
    setState(() {
      ToDo toDo = ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: data);
      toDoProvider.addTodo(toDo);
      print('');
    });
    todoController.clear();
  }

  void runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = toDoProvider.todos;
    } else {
      results = toDoProvider.todos
          .where((item) => item.todoText
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      toDoProvider.foundToDos = results;
    });
  }
  //
  // Widget searchBox() {
  //   return Container(
  //     //padding: const EdgeInsets.symmetric(horizontal: 15),
  //     decoration: BoxDecoration(
  //         color: Colors.white, borderRadius: BorderRadius.circular(20)),
  //     child: TextField(
  //       onChanged: (value) => runFilter(value),
  //       decoration: const InputDecoration(
  //           border: InputBorder.none,
  //           //contentPadding: EdgeInsets.all(0),
  //
  //           prefixIcon: Icon(
  //             Icons.search,
  //             color: tdBlack,
  //           ),
  //           hintText: StringConstant.searchHintTextHomePage,
  //           fillColor: tdBlack),
  //     ),
  //   );
  // }

  AppBar buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.greenAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 25,
              width: 25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  PathConstant.imageAppBarHomePage,
                  fit: BoxFit.fill,
                ),
              ),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
            ),
          ],
        ));
  }
}
