import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_demo/providers/task_provider.dart';

class TaskList extends ConsumerWidget {
  final List<Task> taskList;

  const TaskList({super.key, required this.taskList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        final task = taskList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
          child: Card(
            child: ListTile(
              leading: IconButton(
                icon: Icon(
                  task.isCompleted
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: task.isCompleted ? Colors.green : null,
                ),
                onPressed: () {
                  ref
                      .read(taskListProvider.notifier)
                      .toggleTaskCompletion(index);
                },
              ),
              title: Text(
                task.title,
                style: TextStyle(
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                  color: task.isCompleted ? Colors.grey : null,
                ),
              ),
              subtitle: Text(
                '${task.description}\n${task.date} 까지',
                style: TextStyle(
                  color: task.isCompleted ? Colors.grey.withOpacity(0.5) : null,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  ref.read(taskListProvider.notifier).removeTask(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
