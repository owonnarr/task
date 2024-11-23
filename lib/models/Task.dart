class Task {
  final int? id;
  final String title;
  final String description;
  final String time;
  final bool isImportant;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.isImportant,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'time': time,
      'isImportant': isImportant ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      time: map['time'],
      isImportant: map['isImportant'] == 1,
    );
  }
}