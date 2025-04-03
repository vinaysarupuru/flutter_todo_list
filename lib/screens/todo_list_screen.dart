import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/theme_porvider.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_item_widget.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  Future<void> _exportToJson(WidgetRef ref, BuildContext context) async {
    final todoList = ref.read(todoListProvider.notifier);
    final jsonString = todoList.toJson();
    final encoded = utf8.encode(jsonString);
    // final bytes = Uint8List.fromList(encoded);

    final String? filePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save JSON File',
      fileName: 'todos.json',
      lockParentWindow: true,
      type: FileType.custom,
      allowedExtensions: ['json'],
      bytes: encoded,
    );

    if (filePath != null) {
      // final file = File(filePath);
      // await file.writeAsBytes(encoded);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('JSON exported successfully')),
      );
    }
  }

  Future<void> _exportToCsv(WidgetRef ref, BuildContext context) async {
    final todoList = ref.read(todoListProvider.notifier);
    final csvString = todoList.toCsv();
    final encoded = utf8.encode(csvString);
    // final bytes = Uint8List.fromList(encoded);

    final String? filePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save CSV File',
      fileName: 'todos.csv',
      lockParentWindow: true,
      type: FileType.custom,
      allowedExtensions: ['csv'],
      bytes: encoded,
    );

    if (filePath != null) {
      // final file = File(filePath);
      // await file.writeAsBytes(encoded);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('CSV exported successfully')),
      );
    }
  }

  Future<void> _copyToJson(WidgetRef ref, BuildContext context) async {
    final todoList = ref.read(todoListProvider.notifier);
    final jsonString = todoList.toJson();
    await Clipboard.setData(ClipboardData(text: jsonString));
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('JSON copied to clipboard')));
  }

  Future<void> _copyToCsv(WidgetRef ref, BuildContext context) async {
    final todoList = ref.read(todoListProvider.notifier);
    final csvString = todoList.toCsv();
    await Clipboard.setData(ClipboardData(text: csvString));
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('CSV copied to clipboard')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    final todoList = ref.read(todoListProvider.notifier);
    final themeMode = ref.watch(themeModeProvider);
    final toggleTheme = ref.read(themeModeProvider.notifier).update;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.light
                  ? Icons.brightness_4
                  : Icons.brightness_7,
            ),
            onPressed: () {
              toggleTheme(
                (state) =>
                    state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
              );
            },
          ),
          if (todos.isNotEmpty)
            PopupMenuButton<String>(
              onSelected: (String? item) async {
                if (item == 'json_export') {
                  await _exportToJson(ref, context);
                } else if (item == 'csv_export') {
                  await _exportToCsv(ref, context);
                } else if (item == 'json_copy') {
                  await _copyToJson(ref, context);
                } else if (item == 'csv_copy') {
                  await _copyToCsv(ref, context);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'json_export',
                    child: Text('Export to JSON'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'csv_export',
                    child: Text('Export to CSV'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'json_copy',
                    child: Text('Copy JSON to clipboard'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'csv_copy',
                    child: Text('Copy CSV to clipboard'),
                  ),
                ];
              },
            ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoItem(todo: todo, key: ValueKey(todo.id));
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String newTodoDescription = '';
              return AlertDialog(
                title: const Text('Add Todo'),
                content: TextField(
                  onChanged: (value) {
                    newTodoDescription = value;
                  },
                  decoration: const InputDecoration(hintText: 'Description'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (newTodoDescription.isNotEmpty) {
                        todoList.add(newTodoDescription);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
