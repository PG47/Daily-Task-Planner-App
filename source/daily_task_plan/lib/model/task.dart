class Task {
  String task_name;
  DateTime time;

  Task({required this.task_name, required this.time});

  factory Task.fromString(String name) {
    return Task(
      task_name: name,
      time: DateTime.now(),
    );
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      task_name: map['task'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  Map<String, dynamic> getMap() {
    return {
      'task': this.task_name,
      'time': this.time.microsecondsSinceEpoch,
    };
  }
}
