import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatefulWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  final DateTime? dueDate;
  final TimeOfDay? dueTime;

  ToDoTile({
    Key? key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.dueDate,
    required this.dueTime,
  }) : super(key: key);

  @override
  _ToDoTileState createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      data: {
        'name': widget.taskName,
        'dueDate': widget.dueDate,
        'dueTime': widget.dueTime,
      },
      feedback: Material(
        child: Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 188, 149, 255),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(widget.taskName),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: widget.deleteFunction,
                icon: Icons.delete,
                backgroundColor: Colors.red.shade300,
                borderRadius: BorderRadius.circular(12),
              )
            ],
          ),
          child: GestureDetector(
            onLongPress: () {
              _showEditDialog();
            },
            child: Container(
              padding: EdgeInsets.all(10), // Reduced padding here
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 188, 149, 255),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: widget.taskCompleted,
                        onChanged: widget.onChanged,
                        activeColor: Colors.black,
                      ),
                      Text(
                        widget.taskName,
                        style: TextStyle(
                          decoration: widget.taskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          fontSize: 17.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  if (widget.dueDate != null || widget.dueTime != null)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (widget.dueDate != null)
                            Text(
                              "Date : ${DateFormat('yyyy-MM-dd').format(widget.dueDate!)}",
                              style: TextStyle(
                                color: Color.fromARGB(255, 45, 0, 123),
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (widget.dueTime != null)
                            Text(
                              "Time : ${widget.dueTime!.format(context)}",
                              style: TextStyle(
                                color: Color.fromARGB(255, 45, 0, 123),
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showEditDialog() async {
    TextEditingController nameController = TextEditingController(text: widget.taskName);
    DateTime? selectedDueDate = widget.dueDate;
    TimeOfDay? selectedDueTime = widget.dueTime;

    await showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text("Edit Task"),
      contentPadding: EdgeInsets.all(16), // Add padding to content
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0), // Add padding to TextField
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
          ),
          ListTile(
            title: Text("Due Date"),
            subtitle: selectedDueDate != null
                ? Text(DateFormat('yyyy-MM-dd').format(selectedDueDate!))
                : null,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDueDate ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );

              if (pickedDate != null && pickedDate != selectedDueDate) {
                setState(() {
                  selectedDueDate = pickedDate;
                });
              }
            },
          ),
          ListTile(
            title: Text("Due Time"),
            subtitle: selectedDueTime != null
                ? Text(selectedDueTime!.format(context))
                : null,
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: selectedDueTime ?? TimeOfDay.now(),
              );

              if (pickedTime != null && pickedTime != selectedDueTime) {
                setState(() {
                  selectedDueTime = pickedTime;
                });
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            // Save changes here
            Navigator.of(context).pop();
          },
          child: Text("Save"),
        ),
      ],
    );
  },
);
  }
}
