import 'package:flutter/material.dart';
import 'package:myapp/core/constants/strings.dart';

class TodoListTile extends StatefulWidget {
  const TodoListTile({super.key});

  @override
  State<TodoListTile> createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {
  bool? isCompleted = true;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: task.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12.0),
            ),
            title: Text(task[index].title),
            subtitle: Text(task[index].description!),
            leading: Checkbox(
              value: isCompleted,
              onChanged: (bool? newValue) {
                setState(() {
                  isCompleted = newValue;
                });
              },
            ),
            trailing: Text(task[index].dueDate.toString()),
            tileColor: Colors.blue,
          ),
        );
      },
    );
  }
}
