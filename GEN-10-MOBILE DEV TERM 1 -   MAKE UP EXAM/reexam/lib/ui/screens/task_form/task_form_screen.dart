import 'package:exam/models/member.dart';
import 'package:exam/models/task.dart';
import 'package:flutter/material.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  List<Member> selectedMembers = [];

  String? _titleError;
  String? _durationError;

  void _submit() {
    setState(() {
      // validate title
      if (_titleController.text.isEmpty) {
        _titleError = 'Enter a task title';
      } else {
        _titleError = null;
      }

      // validate duration
      final duration = int.tryParse(_durationController.text);
      if (duration == null || duration < 1 || duration > 30) {
        _durationError = 'Enter a number of hours';
      } else {
        _durationError = null;
      }
    });

    // only create task if no errors
    if (_titleError == null && _durationError == null) {
      final newTask = Task(
        title: _titleController.text,
        durationInHours: int.parse(_durationController.text),
        members: selectedMembers,
      );
      Navigator.pop(context, newTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title field
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: InputDecoration(
                labelText: 'Tasks title',
                errorText: _titleError,
              ),
            ),
            const SizedBox(height: 8),

            // duration field
            TextField(
              controller: _durationController,
              maxLength: 50,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Task duration in hours',
                errorText: _durationError,
              ),
            ),
            const SizedBox(height: 16),

            // member selection label
            Text(
              'Assigned members (${selectedMembers.length} selected)',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            // member list
            Expanded(
              child: ListView(
                children: Member.values.map((member) {
                  final isSelected = selectedMembers.contains(member);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedMembers.remove(member);
                        } else {
                          selectedMembers.add(member);
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.blue[200]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(member.imagePath),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            member.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // create button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Create Task',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
