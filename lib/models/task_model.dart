class TaskModel {
  final String id;

  final String taskName;
  final String taskDescription;
  final bool isHighPriority;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    this.isCompleted = false,
  });

  /// we convert the TaskModel to a Map.
  /// This allows us to use jsonEncode to convert it to a string and store it in the sharedPref.
  Map<String, dynamic> toJson() {
    return {
      'id': id,

      'taskName': taskName,
      'taskDescription': taskDescription,
      'isHighPriority': isHighPriority,
      "isCompleted": isCompleted,
    };
  }

  /// Currently, we have a map.
  /// We don't need a map within the app.
  /// We need: TaskModel
  /// In other words, we need something that does:
  /// Map -> TaskModel

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],

      taskName: json['taskName'],
      taskDescription: json['taskDescription'],
      isHighPriority: json['isHighPriority'],
      isCompleted: json["isCompleted"] ?? false,
    );
  }

  TaskModel copyWith({
    String? id,
    String? taskName,
    String? taskDescription,
    bool? isHighPriority,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,

      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      isHighPriority: isHighPriority ?? this.isHighPriority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
