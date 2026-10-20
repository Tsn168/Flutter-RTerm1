import 'package:exam/ui/screens/task_form/task_form_screen.dart';
import 'package:exam/ui/widgets/chips/duration_chip.dart';
import 'package:exam/models/member.dart';
import 'package:exam/models/task.dart';
import 'package:exam/ui/screens/tasks/task_tile.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Task> tasks = [
    Task(title: 'Task 1', durationInHours: 1, members: [Member.alex, Member.daniel]),
    Task(title: 'Task 2', durationInHours: 2, members: [Member.mia, Member.noah]),
    Task(title: 'Ronan the best', durationInHours: 30, members: [Member.alex, Member.daniel, Member.ethan, Member.jacob]),
  ];

  int get totalDuration => tasks.fold(0, (sum, task) => sum + task.durationInHours);

  void _openForm() async {
    final newTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (context) => const TaskFormScreen()),
    );
    if (newTask != null) {
      setState(() {
        tasks.add(newTask);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Tasks App"),
            const SizedBox(width: 8),
            DurationChip(durationInHours: totalDuration),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(task: tasks[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openForm,
        child: const Icon(Icons.add),
      ),
    );
  }
}
