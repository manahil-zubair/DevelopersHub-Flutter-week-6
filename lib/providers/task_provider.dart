import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../models/storage.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  // Get only pending tasks
  List<Task> get pendingTasks =>
      _tasks.where((t) => !t.isCompleted).toList();

  // Get only completed tasks
  List<Task> get completedTasks =>
      _tasks.where((t) => t.isCompleted).toList();

  // Load tasks from storage when app starts
  Future<void> loadTasks() async {
    _tasks = await StorageService.loadTasks();
    notifyListeners();
  }

  // Add a new task
  void addTask(String title) {
    _tasks.add(Task(title: title));
    StorageService.saveTasks(_tasks);
    notifyListeners();
  }

  // Delete a task
  void deleteTask(Task task) {
    _tasks.remove(task);
    StorageService.saveTasks(_tasks);
    notifyListeners();
  }

  // Toggle task complete/incomplete
  void toggleTask(Task task) {
    task.isCompleted = !task.isCompleted;
    StorageService.saveTasks(_tasks);
    notifyListeners();
  }

  // Undo a deleted task
  void undoDelete(Task task) {
    _tasks.add(task);
    StorageService.saveTasks(_tasks);
    notifyListeners();
  }
}