import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_demo/constants/todo_filter.dart';
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
  int _selectedFilterIndex = filterAll.index;

  List<Task> _filterTasks(List<Task> tasks) {
    List<Task> filteredTasks;
    switch (_selectedFilterIndex) {
      case 1:
        filteredTasks = tasks.where((task) => !task.isCompleted).toList();
        break;
      case 2:
        filteredTasks = tasks.where((task) => task.isCompleted).toList();
        break;
      default:
        filteredTasks = tasks;
        break;
    }
    filteredTasks.sort((a, b) => a.date.compareTo(b.date));
    return filteredTasks;
  }

  void _setFilter(int index) {
    setState(() {
      _selectedFilterIndex = index;
    });
  }

  String _filterLabel() {
    return filters[_selectedFilterIndex].label;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final taskList = ref.watch(taskListProvider);
    final filteredTasks = _filterTasks(taskList);
    final Map<String, dynamic> taskData = {
      'title': '',
      'description': '',
      'date': DateTime.now(),
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
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Center(
                    child: ToggleButtons(
                      constraints: const BoxConstraints(
                        minHeight: 40.0,
                        minWidth: 80.0,
                      ),
                      isSelected: filters
                          .map((filter) => filter.index == _selectedFilterIndex)
                          .toList(),
                      onPressed: (int index) {
                        _setFilter(index);
                      },
                      borderRadius: BorderRadius.circular(8),
                      selectedBorderColor: theme.primaryColor,
                      fillColor: theme.primaryColor.withOpacity(0.2),
                      children: filters
                          .map((filter) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(filter.label),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10),
                    child: filteredTasks.isNotEmpty
                        ? TaskList(taskList: filteredTasks)
                        : Center(
                            child: Text(
                              '${_filterLabel()}이 없습니다.',
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
