import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskListProvider =
    StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  return TaskListNotifier();
});

class Task {
  final String title;
  final String description;
  final DateTime dateTime;

  Task({
    required this.title,
    required this.description,
    required this.dateTime,
  });
}

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]);

  void addTask(String title, String description) {
    final newTask =
        Task(title: title, description: description, dateTime: DateTime.now());
    state = [...state, newTask];
  }
}
