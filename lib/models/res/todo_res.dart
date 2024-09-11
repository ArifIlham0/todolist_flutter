import 'dart:convert';

List<TodoResponse> todoResponseFromJson(String str) => List<TodoResponse>.from(
    json.decode(str).map((x) => TodoResponse.fromJson(x)));

String todoResponseToJson(List<TodoResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoResponse {
  final String? id;
  final String? user;
  final String? title;
  final String? description;
  final bool? completed;
  final DateTime? time;

  TodoResponse({
    this.id,
    this.user,
    this.title,
    this.description,
    this.completed,
    this.time,
  });

  factory TodoResponse.fromJson(Map<String, dynamic> json) => TodoResponse(
        id: json["_id"],
        user: json["user"],
        title: json["title"],
        description: json["description"],
        completed: json["completed"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "title": title,
        "description": description,
        "completed": completed,
        "time": time?.toIso8601String(),
      };
}
