import 'package:flutter/material.dart';

class Todo{
  String? id;
  String? text;
  bool isDone;
  Todo({
    required this.id,
    required this.text,
    this.isDone = false

  });
  static List<Todo> todoList(){
    return [
      Todo(id: '01', text: 'Morning Exercise', isDone:true),
      Todo(id: '02', text: 'Morning Exercise', isDone:true),
      Todo(id: '03', text: 'Morning Exercise',),
      Todo(id: '04', text: 'Morning Exercise',),
      Todo(id: '05', text: 'Morning Exercise',),
      Todo(id: '06', text: 'Morning Exercise',),
    ];

  }
}