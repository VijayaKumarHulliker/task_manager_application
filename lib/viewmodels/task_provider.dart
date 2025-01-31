import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../services/database_service.dart';

final taskSortOrderProvider = StateProvider<String>((ref) => "date");

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier(ref);
});

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier(this.ref) : super([]) {
    loadTasks();
  }

  final DatabaseService _dbService = DatabaseService();
  final Ref ref;

  Future<void> loadTasks() async {
    final sortOrder = ref.read(taskSortOrderProvider);
    List<Task> tasks = await _dbService.getTasks();

    if (sortOrder == "title") {
      tasks.sort((a, b) => a.title.compareTo(b.title));
    } else if (sortOrder == "completed") {
      tasks.sort((a, b) => a.isCompleted ? 1 : -1);
    } else {
      tasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }

    state = tasks;
  }

  Future<void> addTask(Task task) async {
    await _dbService.insertTask(task);
    loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await _dbService.deleteTask(id);
    loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _dbService.updateTask(task);
    loadTasks();
  }
}
