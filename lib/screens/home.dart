import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';

import '../models/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = Todo.todoList();
  final _textEditingController = TextEditingController();
  List<Todo> _foundTodo = [];
  bool isClicked = false;
  @override
  void initState() {
   _foundTodo = todoList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:isClicked==false? Color(0xFFEEEFF5):Color(0xFF141525),
      appBar: _buildAppBar(),
      body: Stack(

        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [

                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child:isClicked? Text(
                          "All ToDos ",

                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500,color: Colors.white),
                        ):Text(
                          "All ToDos ",

                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (Todo todoo in _foundTodo.reversed)
                        TodoItem(
                          todo: todoo, onchangeText: _onVoidChanged,onDelete: _onDeleteItem

                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0)
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                          hintText: "Add new Todo Item",
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  padding: EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDoItem(_textEditingController.text);
                    },
                    child: Icon(Icons.add,color: Colors.white,),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlue,
                        minimumSize: Size(67, 60), // Set the minimum size
                        maximumSize: Size(67, 60), // Set the maximum size
                        elevation: 5),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
void _onVoidChanged(Todo todo){
   setState(() {
     todo.isDone = !todo.isDone;
   });
}
void _onDeleteItem(String id){
   setState(() {
     todoList.removeWhere((value) => value.id == id);
   });
}
void _addToDoItem(String todo){
    setState(() {
      todoList.add(Todo(id: DateTime.now().millisecondsSinceEpoch.toString(), text: todo));
    });
    _textEditingController.clear();
}
void _runFilter(String enteredKeyword){
    List<Todo> results = [];
    if(enteredKeyword.isEmpty){
      results = todoList;
    }else{
      results = todoList.where((item) => item.text!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }
    setState(() {
      _foundTodo = results;
    });
}
  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: tdGrey)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(

      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),

            child: Row(

              children: [
                ElevatedButton(onPressed: (){

                  setState(() {
                    isClicked=!isClicked;
                  });
                }, child: Icon(isClicked?Icons.dark_mode:Icons.light_mode)),
              ],
            ),
          ),
          // Container(
          //   height: 40,
          //   width: 40,
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(20),
          //     child: Image.asset('assets/images/logo.jpg'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
