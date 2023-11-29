class TaskEntity {

  final String id;
  final String title;
  final String description;

  TaskEntity({required this.title, required this.description, required this.id});

  factory TaskEntity.fromJson(Map<String, dynamic> json) {
    return TaskEntity(
      title: json['title'],
      description: json['description'], id: json['id'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['title'] = title;
    data['description'] = description;
    data['id'] = id;

    return data;
  }
}
