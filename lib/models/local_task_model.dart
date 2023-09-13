class LocalTaskModel {
  String task;
  String location;
  DateTime date;
  String details;
  DateTime createDate;

  LocalTaskModel({
    required this.task,
    required this.location,
    required this.date,
    required this.details,
    required this.createDate,
  });

  Map<String, dynamic> toMap(LocalTaskModel taskModel) {
    Map<String, dynamic> taskModelMap = Map();
    taskModelMap["task"] = taskModel.task;
    taskModelMap["location"] = taskModel.location;
    taskModelMap["date"] = taskModel.date;
    taskModelMap["details"] = taskModel.details;
    taskModelMap["createDate"] = taskModel.createDate;

    return taskModelMap;
  }

  factory LocalTaskModel.fromMap(Map<String, dynamic> json) => LocalTaskModel(
    task: json['task'] ?? '',
    location: json['location'] ?? 0,
    date: json['date'] ?? 0,
    details: json['details'] ?? '',
    createDate: json['createDate'] ?? '',
  );
}
