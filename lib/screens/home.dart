import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_demo/providers/task_provider.dart';
import 'package:flutter_riverpod_demo/widgets/add_task_bottomsheet.dart';
import 'package:flutter_riverpod_demo/widgets/empty_task_list.dart';
import 'package:flutter_riverpod_demo/widgets/task_list.dart';

class MyHome extends ConsumerWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final taskList = ref.watch(taskListProvider);
    final Map<String, String> taskData = {
      'title': '',
      'description': '',
      'date': ''
    };

    void addTask() {
      ref.read(taskListProvider.notifier).addTask(
            taskData['title']!,
            taskData['description']!,
            taskData['date']!,
          );
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 목록', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: taskList.isNotEmpty ? const TaskList() : const EmptyTaskList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AddTaskBottomSheet(
                    taskData: taskData,
                    onPressed: addTask,
                  ),
                ],
              ),
            ),
          );
        },
        backgroundColor: theme.primaryColor,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[20],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
