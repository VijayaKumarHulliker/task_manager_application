import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/viewmodels/task_provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider); 
    final themeNotifier = ref.read(themeProvider.notifier); 
    final taskNotifier = ref.read(taskProvider.notifier);
    final currentSortOrder = ref.watch(taskSortOrderProvider); 

    return Scaffold(
      appBar: AppBar(title: const Text("Settings"),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text("Dark Mode"),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  themeNotifier.state = value; 
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text("Sort Tasks By:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: currentSortOrder, 
              onChanged: (newOrder) {
                if (newOrder != null) {
                  ref.read(taskSortOrderProvider.notifier).state = newOrder;
                  taskNotifier.loadTasks(); 
                }
              },
              items: const [
                DropdownMenuItem(value: "date", child: Text("Date")),
                DropdownMenuItem(value: "title", child: Text("Title")),
                DropdownMenuItem(value: "completed", child: Text("Completed")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
