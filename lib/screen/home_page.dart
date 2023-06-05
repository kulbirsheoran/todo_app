import 'package:flutter/material.dart';
import 'package:todo_app/constant/color_const.dart';
import 'package:todo_app/constant/path_constant.dart';
import 'package:todo_app/constant/routes_const.dart';
import 'package:todo_app/constant/string_constants.dart';
import 'package:todo_app/module/todo.dart';

import 'package:todo_app/screen/todo_item.dart';
import 'package:todo_app/sharedPreference//local_data_saver.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todosList = ToDo.todoList();
  List<ToDo> foundTodo = [];
  final todoController = TextEditingController();

  @override
  void initState() {
    foundTodo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Center(
          child: InkWell(
            child: const Text(StringConstant.logoutHomePage),
            onTap: () {
              LocalDataSaver.removeAll();
              Navigator.pushReplacementNamed(context,Routes.loginScreen
                  );
            },
          ),
        ),
      ),
      backgroundColor: Colors.greenAccent,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
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
                      for (ToDo todos in foundTodo.reversed)
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
                          color: Colors.cyan,
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
      ),
    );
  }

  void handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void addToDoItem(String toDO) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDO));
    });
    todoController.clear();
  }

  void runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundTodo = results;
    });
  }

  Widget searchBox() {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => runFilter(value),
        decoration: const InputDecoration(
            border: InputBorder.none,
            //contentPadding: EdgeInsets.all(0),

            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
            ),
            hintText: StringConstant.searchHintTextHomePage,
            fillColor: tdBlack),
      ),
    );
  }

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

