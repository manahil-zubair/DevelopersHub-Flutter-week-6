import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task_model.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final pendingTasks = taskProvider.pendingTasks;
    final completedTasks = taskProvider.completedTasks;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F2F1),
              Color(0xFFF1F8F5),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task Manager',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Manage your daily tasks',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddTaskScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF80CBC4), Color(0xFF4CAF7D)],
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4CAF7D).withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 28),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _buildStatCard(
                      'Pending',
                      pendingTasks.length.toString(),
                      const Color(0xFFB2DFDB),
                      Icons.radio_button_unchecked,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      'Completed',
                      completedTasks.length.toString(),
                      const Color(0xFFA5D6A7),
                      Icons.check_circle_outline,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      'Total',
                      taskProvider.tasks.length.toString(),
                      const Color(0xFF80CBC4),
                      Icons.list_alt,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: taskProvider.tasks.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.checklist,
                        size: 80,
                        color: Colors.black.withValues(alpha: 0.15),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No tasks yet!',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Tap + to add a new task',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                )
                    : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    if (pendingTasks.isNotEmpty) ...[
                      const Text(
                        'Pending',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...pendingTasks.map((task) => _buildTaskCard(context, task)),
                      const SizedBox(height: 20),
                    ],
                    if (completedTasks.isNotEmpty) ...[
                      const Text(
                        'Completed',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...completedTasks.map((task) => _buildTaskCard(context, task)),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String count, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.5)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF4CAF7D), size: 20),
            const SizedBox(height: 4),
            Text(
              count,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, Task task) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: task.isCompleted
              ? [const Color(0xFFE8F5E9), const Color(0xFFC8E6C9)]
              : [Colors.white, const Color(0xFFF1F8F5)],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: GestureDetector(
          onTap: () => taskProvider.toggleTask(task),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              task.isCompleted
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              key: ValueKey(task.isCompleted),
              color: const Color(0xFF4CAF7D),
              size: 28,
            ),
          ),
        ),
        title: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            fontSize: 16,
            color: task.isCompleted ? Colors.black38 : Colors.black87,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            fontWeight: task.isCompleted ? FontWeight.normal : FontWeight.w500,
          ),
          child: Text(task.title),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: () {
            taskProvider.deleteTask(task);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Task deleted'),
                backgroundColor: const Color(0xFF4CAF7D),
                duration: const Duration(seconds: 5),
                persist: false,
                action: SnackBarAction(
                  label: 'Undo',
                  textColor: Colors.white,
                  onPressed: () => taskProvider.undoDelete(task),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}