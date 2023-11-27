class TaskEntity {
  final String title;
  final String description;

  TaskEntity({required this.title, required this.description});

  factory TaskEntity.fromJson(Map<String, dynamic> json) {
    return TaskEntity(
      title: json['title'],
      description: json['description'],
    );
  }
}
