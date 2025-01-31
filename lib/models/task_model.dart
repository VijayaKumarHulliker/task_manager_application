class Task {
  int? id; 
  String title;
  String description;
  bool isCompleted;
  DateTime createdAt;

  Task({
    this.id, 
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
    };
  }


  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

