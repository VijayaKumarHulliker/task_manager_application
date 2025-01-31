import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/viewmodels/task_provider.dart';
import '../models/task_model.dart';

class TaskDetailScreen extends ConsumerWidget {
  final Task task; 
  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController titleController = TextEditingController(text: task.title);
    TextEditingController descriptionController = TextEditingController(text: task.description);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final updatedTask = Task(
                id: task.id, 
                title: titleController.text,
                description: descriptionController.text,
                isCompleted: task.isCompleted, 
                createdAt: task.createdAt,
              );

              ref.read(taskProvider.notifier).updateTask(updatedTask);

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
            TextField(
              controller: titleController,  
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController, 
              decoration: const InputDecoration(labelText: 'Task Description'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Status:"),
                Switch(
                  value: task.isCompleted,
                  onChanged: (bool value) {
                    final updatedTask = Task(
                      id: task.id,
                      title: titleController.text,
                      description: descriptionController.text,
                      isCompleted: value,  
                      createdAt: task.createdAt,
                    );

               
                    ref.read(taskProvider.notifier).updateTask(updatedTask);
                  },
                ),
                Text(task.isCompleted ? "Completed" : "Pending"),  
              ],
            ),
          ],
        ),
      ),
    );
  }
}
