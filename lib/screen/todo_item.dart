import 'package:flutter/material.dart';
import 'package:todo_app/constant/color_const.dart';
import 'package:todo_app/module/todo.dart';


class ToDoItem extends StatelessWidget {
  final ToDo toDo;
  final Function onToDoChanged;
  final Function onDeleteItem;

  const ToDoItem(
      {Key? key,
      required this.toDo,
      required this.onToDoChanged,
      required this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: ListTile(
          onTap: () {
            onToDoChanged(toDo);
          },
          leading: Icon(
            toDo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            // Icons.check_box,
            color: Colors.green,
          ),
          title: Text(
            toDo.todoText!,
            style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: toDo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          //const Text("Check mail"),

          trailing: Container(
            padding: const EdgeInsets.all(0),
            // alignment: Alignment.topLeft,
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.cyan, borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: () {
                onDeleteItem(toDo.id);
              },
              icon: const Icon(Icons.delete),
              iconSize: 15,
              color: Colors.white,
            ),
          ),
        ));
  }
}
