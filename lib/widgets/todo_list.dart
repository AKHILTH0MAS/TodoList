import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../constants/color.dart';

class TodoList extends StatelessWidget {
  final Todo todo;
  final Function(Todo) todoonchanged;
  final Function(String?) ondeleteitem;
  const TodoList({
    super.key,
    required this.todo,
    required this.todoonchanged,
    required this.ondeleteitem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          todoonchanged(todo);
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                todo.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
              ),
              Text(
                todo.todotext!,
                style: const TextStyle(fontSize: 18),
              ),
              Container(
                height: 30,
                width: 30,
                color: tdred,
                child: IconButton(
                  onPressed: () {
                    ondeleteitem(todo.id);
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
