import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/viewmodels/task_provider.dart';
import '../models/task_model.dart';

class TaskDetailScreen extends ConsumerWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskNotifier = ref.read(taskProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              taskNotifier.deleteTask(task.id!);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              task.description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text("Status:", style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Chip(
                  label: Text(
                    task.isCompleted ? "Completed" : "Pending",
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: task.isCompleted ? Colors.green : Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Task updatedTask = Task(
                  id: task.id,
                  title: task.title,
                  description: task.description,
                  isCompleted: !task.isCompleted,
                  createdAt: task.createdAt,
                );
                taskNotifier.updateTask(updatedTask);
                Navigator.pop(context);
              },
              child: Text(task.isCompleted ? "Mark as Pending" : "Mark as Completed"),
            ),
          ],
        ),
      ),
    );
  }
}
