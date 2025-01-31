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
        title: const Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
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
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
