class TaskModel {
  String? id;
  String? title;
  String? description;
  String? date;
  String? startTime;
  String? endTime;
  bool? isCompleted;
  String? createdAt;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.date,
    this.startTime,
    this.endTime,
    this.isCompleted,
    this.createdAt,
  });
}