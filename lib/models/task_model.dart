class TaskModel {
  String title;
  bool isDone;
  bool deleted;

  TaskModel({required this.title, this.isDone = false, this.deleted = false});

  // For storing in shared_preferences
  Map<String, dynamic> toJson() => {
        'title': title,
        'isDone': isDone,
        'deleted': false,
      };

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json['title'],
        isDone: json['isDone'],
        deleted: json['deleted'],
      );
}
