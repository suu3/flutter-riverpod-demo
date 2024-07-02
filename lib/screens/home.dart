import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_demo/providers/task_provider.dart';
import 'package:flutter_riverpod_demo/widgets/add_task_bottomsheet.dart';
import 'package:flutter_riverpod_demo/widgets/empty_task_list.dart';

class MyHome extends ConsumerWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final taskList = ref.watch(taskListProvider);
    final Map<String, String> taskData = {'title': '', 'description': ''};

    void addTask() {
      ref.read(taskListProvider.notifier).addTask(
            taskData['title']!,
            taskData['description']!,
          );
      Navigator.of(context).pop();
    }

    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.menu, color: Colors.white),
      //     onPressed: () {},
      //   ),
      //   title: const Text('Home', style: TextStyle(color: Colors.white)),
      //   centerTitle: true,
      //   // actions: [
      //   //   IconButton(
      //   //     icon: const CircleAvatar(
      //   //       backgroundImage: AssetImage('assets/profile_image.png'),
      //   //     ),
      //   //     onPressed: () {},
      //   //   ),
      //   // ],
      // ),

      body: taskList.isNotEmpty
          ? ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                final task = taskList[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                  child: Card(
                    child: ListTile(
                      leading: const Icon(Icons.radio_button_unchecked),
                      title: Text(task.title),
                      subtitle: Text(
                        task.description,
                      ),
                    ),
                  ),
                );
              },
            )
          : const EmptyTaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            builder: (context) {
              return AddTaskBottomSheet(
                taskData: taskData,
                onPressed: addTask,
              );
            },
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.calendar_today),
          //   label: 'Calendar',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.timer),
          //   label: 'Focus',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
