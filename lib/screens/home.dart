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
  int _selectedFilterIndex = 0;

  List<Task> _filterTasks(List<Task> tasks) {
    if (_selectedFilterIndex == 1) {
      return tasks.where((task) => !task.isCompleted).toList();
    } else if (_selectedFilterIndex == 2) {
      return tasks.where((task) => task.isCompleted).toList();
    }
    return tasks;
  }

  void _setFilter(int index) {
    setState(() {
      _selectedFilterIndex = index;
    });
  }

  String _filterLabel() {
    switch (_selectedFilterIndex) {
      case 1:
        return '미완료된 할 일';
      case 2:
        return '완료된 할 일';
      default:
        return '전체 할 일';
    }
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
                  child: Center(
                    child: ToggleButtons(
                      isSelected: [
                        _selectedFilterIndex == 0,
                        _selectedFilterIndex == 1,
                        _selectedFilterIndex == 2
                      ],
                      onPressed: (int index) {
                        _setFilter(index);
                      },
                      borderRadius: BorderRadius.circular(8),
                      selectedBorderColor: theme.primaryColor,
                      fillColor: theme.primaryColor.withOpacity(0.2),
                      constraints: const BoxConstraints(
                        minHeight: 40.0, // 여기서 버튼의 최소 높이를 설정합니다.
                        minWidth: 80.0, // 버튼의 최소 너비를 설정할 수도 있습니다.
                      ),
                      children: const [
                        Text('전체'),
                        Text('미완료'),
                        Text('완료'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
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
