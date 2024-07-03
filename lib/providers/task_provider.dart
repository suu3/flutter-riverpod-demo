import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskListProvider =
    StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  return TaskListNotifier();
});

class Task {
  final String title;
  final String description;
  final String date;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.date,
    this.isCompleted = false,
  });
}

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]);

  void addTask(String title, String description, String date) {
    final newTask = Task(title: title, description: description, date: date);
    state = [...state, newTask];
  }

  void removeTask(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }

  void toggleTaskCompletion(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Task(
            title: state[i].title,
            description: state[i].description,
            date: state[i].date,
            isCompleted: !state[i].isCompleted,
          )
        else
          state[i],
    ];
  }
}
