import "package:flutter/material.dart";
import "package:flutter_application_1/util/dialog_box.dart";
import "package:flutter_application_1/util/todo_tile.dart";
// Import 'dart:ffi' only for non-web platforms

class Task {
  String name;
  bool completed;
  DateTime? dueDate;
  TimeOfDay? dueTime;

  Task({
    required this.name,
    required this.completed,
    this.dueDate,
    this.dueTime,
  });
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final _controller = TextEditingController();

  List<Task> toDoList = [
  Task(
    name: "Make tutorial",
    completed: false,
    dueDate: DateTime.now().add(Duration(days: 2)), // Add a due date example
    dueTime: TimeOfDay(hour: 14, minute: 30), // Add a due time example
  ),
  Task(
    name: "Do Exercise",
    completed: false,
    dueDate: DateTime.now().add(Duration(days: 3)), // Add a due date example
    dueTime: TimeOfDay(hour: 18, minute: 0), // Add a due time example
  ),
];


  void checkboxChanged(bool? value, int index) {
    setState(() {
      toDoList[index].completed = !toDoList[index].completed;
    });
  }

  void saveNewTask(DateTime? dueDate, TimeOfDay? dueTime) {
    print("Due Date: $dueDate, Due Time: $dueTime");
    setState(() {
      toDoList.add(Task(
        name: _controller.text,
        completed: false,
        dueDate: dueDate,
        dueTime: dueTime,
      ));
      _controller.clear();
    });
    Navigator.of(context).pop();
  }


 void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: (dueDate, dueTime) => saveNewTask(dueDate, dueTime),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(255, 212, 188, 255),
     appBar: AppBar(
      title: Text('TO DO'),
      backgroundColor: Color.fromARGB(255, 188, 149, 255),
      toolbarHeight: 80,
     ),
     floatingActionButton: FloatingActionButton(
      backgroundColor: Color.fromARGB(255, 188, 149, 255),
      onPressed: createNewTask,
      child: Icon(Icons.add) ,
      ),
     body: ListView.builder(
      itemCount: toDoList.length,
      itemBuilder: (context, index) {
        return ToDoTile(
          key: Key('uniqueKey$index'), // You can provide a unique key if needed
          taskName: toDoList[index].name,
          taskCompleted: toDoList[index].completed,
          onChanged: (value) => checkboxChanged(value, index),
          deleteFunction: (context) => deleteTask(index),
          dueDate: toDoList[index].dueDate!, // Assuming dueDate is never null
          dueTime: toDoList[index].dueTime!, // Assuming dueTime is never null
        );
      }, 
     ),
  );
  }
}