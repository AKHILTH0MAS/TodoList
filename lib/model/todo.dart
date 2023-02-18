class Todo {
  String? id;
  String? todotext;
  bool? isDone;
  Todo({
    required this.id,
    required this.todotext,
    this.isDone = false,
  });
  static List<Todo> todoList() {
    return [
      Todo(
        id: '1',
        todotext: 'Buy Milk',
        isDone: false,
      ),
      Todo(
        id: '2',
        todotext: 'Example Todo',
        isDone: false,
      ),
      Todo(
        id: '3',
        todotext: 'Have some fun',
        isDone: false,
      ),
    ];
  }
}
