class Task {
  String title;
  bool isCompleted;

  Task({
    required this.title,
    this.isCompleted = false,
  });

  // Convert task to a map so we can save it
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  // Create a task from a saved map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      isCompleted: map['isCompleted'],
    );
  }
}