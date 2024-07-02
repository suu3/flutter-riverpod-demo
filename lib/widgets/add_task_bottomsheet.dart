import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTaskBottomSheet extends ConsumerWidget {
  final Map<String, String> taskData;
  final VoidCallback onPressed;

  const AddTaskBottomSheet({
    super.key,
    required this.taskData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '할 일 추가',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (value) {
              taskData['title'] = value;
            },
            decoration: InputDecoration(
              labelText: '할 일을 입력하세요.',
              labelStyle: TextStyle(color: Colors.grey[700]),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (value) {
              taskData['description'] = value;
            },
            decoration: InputDecoration(
              labelText: '할 일에 대한 설명을 작성하세요.',
              labelStyle: TextStyle(color: Colors.grey[700]),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Icon(Icons.timer, size: 30),
              // Icon(Icons.location_on, size: 30),
              // Icon(Icons.flag, size: 30),
              IconButton(
                icon: const Icon(Icons.send, size: 30, color: Colors.purple),
                onPressed: onPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
