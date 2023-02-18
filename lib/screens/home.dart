import 'package:flutter/material.dart';
import '../constants/color.dart';
import '../model/todo.dart';
import '../widgets/todo_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoslist = Todo.todoList();
  List<Todo> foundTodos = [];
  final todolistcontroller = TextEditingController();
  void _handletodochange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void runFilter(String enterdKeyword) {
    List<Todo> results = [];
    if (enterdKeyword.isEmpty) {
      results = todoslist;
    } else {
      results = todoslist
          .where((element) => element.todotext!
              .toLowerCase()
              .contains(enterdKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundTodos = results;
    });
  }

  void _deleteitem(String? id) {
    setState(() {
      todoslist.removeWhere((element) => element.id == id);
    });
  }

  void addTodoitem(String accptedtodo) {
    setState(() {
      todoslist.add(
        Todo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          todotext: accptedtodo,
        ),
      );
      todolistcontroller.clear();
    });
  }

  @override
  void initState() {
    foundTodos = todoslist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBG,
      appBar: AppBar(
        backgroundColor: tdBG,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
            const SizedBox(
              width: 250,
            ),
            SizedBox(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset('assets/images/todo.png'),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    onChanged: (value) => runFilter(value),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "All Todo lists",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                for (Todo todo in foundTodos.reversed)
                  TodoList(
                    todo: todo,
                    todoonchanged: _handletodochange,
                    ondeleteitem: _deleteitem,
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: todolistcontroller,
                      decoration: const InputDecoration(
                        hintText: 'Add new todo',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      addTodoitem(todolistcontroller.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      minimumSize: const Size(40, 40),
                      elevation: 10,
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
