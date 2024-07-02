import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskListProvider =
    StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  return TaskListNotifier();
});

class Task {
  final String title;
  final String description;
  final DateTime dateTime;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.dateTime,
    this.isCompleted = false,
  });
}

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]);

  void addTask(String title, String description) {
    final newTask =
        Task(title: title, description: description, dateTime: DateTime.now());
    state = [...state, newTask];
  }

  void toggleTaskCompletion(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Task(
            title: state[i].title,
            description: state[i].description,
            dateTime: state[i].dateTime,
            isCompleted: !state[i].isCompleted,
          )
        else
          state[i],
    ];
  }
}
