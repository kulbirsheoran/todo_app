class ToDo{
  String? id;
  String? todoText;
  bool isDone;


  ToDo({required this.id,required this.todoText,this.isDone=false,});

 // get todoText => null;

   static List<ToDo>  todoList() {
  return [ToDo(id: '1', todoText: "Morning Exercise", isDone: true,),
    ToDo(id: '2', todoText: "Buy Groceries", isDone: true,),
  ];
}
}
