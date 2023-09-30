import 'package:flutter/material.dart';

import '../models/TodoFunct.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final TodoChanged;
  final SupprimerItem;
  const ToDoItem({super.key, required this.todo, this.TodoChanged, this.SupprimerItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: (){
          TodoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        // contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone? Icons.check_box : Icons.check_box_outline_blank, 
          color: Colors.blue,),
        title: Text(
          todo.Text!,
        style: TextStyle(
          fontSize: 16, 
          color: Colors.black, 
          decoration: todo.isDone?  TextDecoration.lineThrough : null,
          ),),
          trailing: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(vertical: 12),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
               color: Colors.white,
               icon: Icon(Icons.delete),
               iconSize: 18,
               onPressed: (){
                SupprimerItem(todo.id);
               },
              ),
          ),
      

      ),
    );
  }
}