// TasksScreen
import 'package:exam/models/member.dart';
import 'package:exam/models/task.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Task> tasks = [
    Task(
      title: 'Work',
      durationInHours: 12,
      members: [Member.alex],
    ),
    Task(title: 'Design', durationInHours: 1, members: [Member.daniel])
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task"),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
          );
        },
      ),
    );
  }
}
