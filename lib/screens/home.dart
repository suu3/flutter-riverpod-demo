import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_demo/providers/task_provider.dart';
import 'package:flutter_riverpod_demo/widgets/add_task_bottomsheet.dart';
import 'package:flutter_riverpod_demo/widgets/empty_task_list.dart';
import 'package:flutter_riverpod_demo/widgets/task_list.dart';

class MyHome extends ConsumerStatefulWidget {
  const MyHome({super.key});

  @override
  ConsumerState<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends ConsumerState<MyHome> {
  String _selectedFilter = '전체';

  List<Task> _filterTasks(List<Task> tasks) {
    if (_selectedFilter == '완료된 할 일') {
      return tasks.where((task) => task.isCompleted).toList();
    } else if (_selectedFilter == '미완료된 할 일') {
      return tasks.where((task) => !task.isCompleted).toList();
    }
    return tasks;
  }

  void _setFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final taskList = ref.watch(taskListProvider);
    final filteredTasks = _filterTasks(taskList);
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
      body: taskList.isEmpty
          ? const EmptyTaskList()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => _setFilter('전체'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedFilter == '전체'
                              ? theme.primaryColor
                              : Colors.grey,
                        ),
                        child: const Text('전체'),
                      ),
                      ElevatedButton(
                        onPressed: () => _setFilter('미완료된 할 일'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedFilter == '미완료된 할 일'
                              ? theme.primaryColor
                              : Colors.grey,
                        ),
                        child: const Text('미완료'),
                      ),
                      ElevatedButton(
                        onPressed: () => _setFilter('완료된 할 일'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedFilter == '완료된 할 일'
                              ? theme.primaryColor
                              : Colors.grey,
                        ),
                        child: const Text('완료'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: filteredTasks.isNotEmpty
                        ? TaskList(taskList: filteredTasks)
                        : Center(
                            child: Text(
                              '$_selectedFilter이 없습니다.',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.grey),
                            ),
                          ),
                  ),
                ),
              ],
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
