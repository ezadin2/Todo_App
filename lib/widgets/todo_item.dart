import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/models/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo, required this.onchangeText, this.onDelete});
final Todo todo;
final  onchangeText;
final  onDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          print(todo.isDone);
          onchangeText(todo);
          print(todo.isDone);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone? Icons.check_box:Icons.check_box_outline_blank_outlined,
          color: tdBlue,
        ),
        title: Text(
          todo.text!,
          style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration:todo.isDone? TextDecoration.lineThrough:null),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical:12),
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5)
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: (){
              onDelete(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
