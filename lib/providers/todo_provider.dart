import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../models/todo_entitydart';

class TodoList extends StateNotifier<List<Todo>> {
  TodoList() : super([]);

  void add(String description) {
    var uuid = const Uuid();
    String time = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now());

    state = [
      ...state,
      Todo(
        id: uuid.v4().substring(0, 8),
        description: description,
        timestamp: time,
      ),
    ];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(completed: !todo.completed) else todo,
    ];
  }

  void delete(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  String toJson() {
    final List<Map<String, dynamic>> jsonList =
        state.map((todo) => todo.toJson()).toList();
    return jsonEncode(jsonList);
  }

  String toCsv() {
    if (state.isEmpty) {
      return '';
    }
    String csv = 'id,description,completed,timestamp\n';
    for (final todo in state) {
      csv += '$todo\n';
    }
    return csv;
  }
}

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList();
});
