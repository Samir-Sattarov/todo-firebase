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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['title'] = title;
    data['description'] = description;

    return data;
  }
}
