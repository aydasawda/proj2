
import 'package:flutter/material.dart';
import 'task.dart';

class ContainerWidget extends StatefulWidget {
  final String title;
  final VoidCallback onDelete;


  ContainerWidget({required this.title, required this.onDelete,
   });

  @override
  _ContainerWidgetState createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  List<Task> tasks = [];

  void addTask(String taskTitle) {
    setState(() {
      tasks.add(Task(title: taskTitle));
    });
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void toggleTaskStatus(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'folder: ${widget.title}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: widget.onDelete,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  TextEditingController _controller = TextEditingController();
                  return AlertDialog(
                    title: Text('Add Task to ${widget.title}'),
                    content: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Task',
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          addTask(_controller.text);
                          Navigator.of(context).pop();
                        },
                        child: Text('Add Task'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Add Task'),
          ),
          buildTaskList(),
        ],
      ),
    );
  }

  Widget buildTaskList() {
    if (tasks.isEmpty) {
      return Text('No tasks yet.');
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: tasks.asMap().entries.map((entry) {
          final index = entry.key;
          final task = entry.value;
          return ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () => toggleTaskStatus(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => removeTask(index),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }
  }
}
