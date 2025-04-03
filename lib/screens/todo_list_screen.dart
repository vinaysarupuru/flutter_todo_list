import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/theme_porvider.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_item_widget.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  Future<void> _exportToJson(WidgetRef ref) async {
    final todoList = ref.read(todoListProvider.notifier);
    final jsonString = todoList.toJson();

    final Uri url = Uri.dataFromString(
      jsonString,
      mimeType: 'application/json',
      encoding: Encoding.getByName('utf-8'),
    );

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _exportToCsv(WidgetRef ref) async {
    final todoList = ref.read(todoListProvider.notifier);
    final csvString = todoList.toCsv();

    final Uri url = Uri.dataFromString(
      csvString,
      mimeType: 'text/csv',
      encoding: Encoding.getByName('utf-8'),
    );
    try {
      launchUrl(url);
    } catch (e) {
      debugPrint('Could not launch $url because $e');
    }
  }

  Future<void> _copyToJson(WidgetRef ref) async {
    final todoList = ref.read(todoListProvider.notifier);
    final jsonString = todoList.toJson();
    await Clipboard.setData(ClipboardData(text: jsonString));
    ScaffoldMessenger.of(
      ref.context,
    ).showSnackBar(const SnackBar(content: Text('JSON copied to clipboard')));
  }

  Future<void> _copyToCsv(WidgetRef ref) async {
    final todoList = ref.read(todoListProvider.notifier);
    final csvString = todoList.toCsv();
    await Clipboard.setData(ClipboardData(text: csvString));
    ScaffoldMessenger.of(
      ref.context,
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
          PopupMenuButton<String>(
            onSelected: (String? item) async {
              if (item == 'json_export') {
                await _exportToJson(ref);
              } else if (item == 'csv_export') {
                await _exportToCsv(ref);
              } else if (item == 'json_copy') {
                await _copyToJson(ref);
              } else if (item == 'csv_copy') {
                await _copyToCsv(ref);
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
