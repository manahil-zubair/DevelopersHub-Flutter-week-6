import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'task_model.dart';

class StorageService {
  static const String _key = 'tasks';

  // Save list of tasks
  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(
      tasks.map((task) => task.toMap()).toList(),
    );
    await prefs.setString(_key, encoded);
  }

  // Load list of tasks
  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encoded = prefs.getString(_key);
    if (encoded == null) return [];
    final List<dynamic> decoded = jsonDecode(encoded);
    return decoded.map((item) => Task.fromMap(item)).toList();
  }
}