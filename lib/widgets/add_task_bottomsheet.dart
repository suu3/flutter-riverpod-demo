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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.purple, // Header background color
              onPrimary: Colors.white, // Header text color
              surface: Colors.grey[800]!, // Background color of the calendar
              onSurface: Colors.white, // Text color
            ),
            dialogBackgroundColor: Colors.black,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      taskData['dateTime'] = picked.toIso8601String(); // Save the selected date
    }
  }

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
              IconButton(
                icon: const Icon(Icons.calendar_today, size: 30),
                onPressed: () {
                  _selectDate(context);
                },
              ),
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
