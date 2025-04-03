import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo_entitydart';
import '../providers/todo_provider.dart';

class TodoItem extends ConsumerWidget {
  const TodoItem({required Key key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.read(todoListProvider.notifier);

    Future<void> showDeleteConfirmationDialog(
      BuildContext context,
      String todoId,
    ) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Delete'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure you want to delete this todo?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Delete'),
                onPressed: () {
                  todoList.delete(todoId);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Card(
        elevation: 2,
        child:
            kIsWeb ||
                    defaultTargetPlatform == TargetPlatform.windows ||
                    defaultTargetPlatform == TargetPlatform.linux ||
                    defaultTargetPlatform == TargetPlatform.macOS
                ? ListTile(
                  leading: Checkbox(
                    value: todo.completed,
                    onChanged: (bool? value) {
                      if (value != null) {
                        todoList.toggle(todo.id);
                      }
                    },
                  ),
                  title: Text(
                    todo.description,
                    style: TextStyle(
                      decoration:
                          todo.completed ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Text('Created at: ${todo.timestamp}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDeleteConfirmationDialog(context, todo.id);
                    },
                  ),
                )
                : Dismissible(
                  key: Key(todo.id),
                  onDismissed: (direction) {
                    showDeleteConfirmationDialog(context, todo.id);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      value: todo.completed,
                      onChanged: (bool? value) {
                        if (value != null) {
                          todoList.toggle(todo.id);
                        }
                      },
                    ),
                    title: Text(
                      todo.description,
                      style: TextStyle(
                        decoration:
                            todo.completed ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text('Created at: ${todo.timestamp}'),
                    trailing: null,
                  ),
                ),
      ),
    );
  }
}
