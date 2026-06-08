class TaskModel {
  final String taskName;
  final String taskDescription;
  final bool isHighPriority;

  TaskModel({
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
  });

  /// we convert the TaskModel to a Map.
  /// This allows us to use jsonEncode to convert it to a string and store it in the sharedPref.
  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isHighPriority': isHighPriority,
    };
  }

  /// Currently, we have a map.
  /// We don't need a map within the app.
  /// We need: TaskModel
  /// In other words, we need something that does:
  /// Map -> TaskModel

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskName: json['taskName'],
      taskDescription: json['taskDescription'],
      isHighPriority: json['isHighPriority'],
    );
  }
}
