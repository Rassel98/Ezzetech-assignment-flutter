class TodoModel {
  TodoModel({
      this.userId, 
      this.id, 
      this.title, 
      this.completed,});

  TodoModel.fromJson(dynamic json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }
  num? userId;
  num? id;
  String? title;
  bool? completed;
TodoModel copyWith({  num? userId,
  num? id,
  String? title,
  bool? completed,
}) => TodoModel(  userId: userId ?? this.userId,
  id: id ?? this.id,
  title: title ?? this.title,
  completed: completed ?? this.completed,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['id'] = id;
    map['title'] = title;
    map['completed'] = completed;
    return map;
  }

}