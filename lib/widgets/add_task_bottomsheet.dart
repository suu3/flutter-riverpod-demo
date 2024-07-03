import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final Map<String, String> taskData;
  final VoidCallback onPressed;

  const AddTaskBottomSheet({
    super.key,
    required this.taskData,
    required this.onPressed,
  });

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_updateButtonState);
    _descriptionController.addListener(_updateButtonState);
    _dateController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _titleController.removeListener(_updateButtonState);
    _descriptionController.removeListener(_updateButtonState);
    _dateController.removeListener(_updateButtonState);
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _titleController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty &&
          _dateController.text.isNotEmpty;
    });
  }

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
      setState(() {
        _dateController.text = DateFormat.yMMMd().format(picked);
        widget.taskData['date'] = DateFormat.yMMMd().format(picked);
      });
      _updateButtonState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '할 일 추가',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.send,
                    size: 30,
                    color: _isButtonEnabled ? Colors.purple : Colors.grey),
                onPressed: _isButtonEnabled ? widget.onPressed : null,
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _titleController,
            onChanged: (value) {
              widget.taskData['title'] = value;
            },
            decoration: InputDecoration(
              labelText: '할 일을 입력하세요.',
              labelStyle: TextStyle(color: Colors.grey[700]),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            onChanged: (value) {
              widget.taskData['description'] = value;
            },
            decoration: InputDecoration(
              labelText: '할 일에 대한 설명을 작성하세요.',
              labelStyle: TextStyle(color: Colors.grey[700]),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _dateController,
            readOnly: true,
            onTap: () {
              _selectDate(context);
            },
            decoration: InputDecoration(
              labelText: '마감 날짜',
              labelStyle: TextStyle(color: Colors.grey[700]),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
