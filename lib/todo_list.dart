// todo_list.dart
import 'package:flutter/material.dart';
import 'container.widget.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {


  bool isDarkMode = false;

  void toggleDarkMode() {
  setState(() {
  isDarkMode = !isDarkMode;
  });
  }

  List<ContainerWidget> containers = [];

  void addContainer(String title) {
    setState(() {
      containers.add(ContainerWidget(
        title: title,
        onDelete: () {
          removeContainer(containers.indexOf(
              containers.firstWhere((c) => c.title == title)));
        },
      ));
    });
  }

  void removeContainer(int index) {
    setState(() {
      containers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    var floatingActionButton;
    return MaterialApp(


      theme: isDarkMode ? ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.blueGrey.shade700,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white, // Change the text color for dark mode
          ),
          bodyText2: TextStyle(
            color: Colors.white,
          ),

      ), ): ThemeData( primarySwatch: Colors.pink,
      scaffoldBackgroundColor: Colors.pink.shade50
        ,

      ),
      home: Scaffold(
      appBar: AppBar(

        title: Text('Your todo-list',),centerTitle: true,
      ),
      body: Column(
        children: [

          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  TextEditingController _controller = TextEditingController();
                  return AlertDialog(
                    title: Text('Add a list'),
                    content: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'list Title',
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          addContainer(_controller.text);
                          Navigator.of(context).pop();
                        },
                        child: Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Add a list '),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: containers.length,
              itemBuilder: (context, index) {
                return containers[index];
              },
            ),
          ),
        ],
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: toggleDarkMode,
          child: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
        ),

      ),
    );
  }
}
