import 'dart:convert';

TodoRequest todoRequestFromJson(String str) =>
    TodoRequest.fromJson(json.decode(str));

String todoRequestToJson(TodoRequest data) => json.encode(data.toJson());

class TodoRequest {
  final String? title;
  final String? description;
  final bool? completed;
  final DateTime? time;

  TodoRequest({
    this.title,
    this.description,
    this.completed,
    this.time,
  });

  factory TodoRequest.fromJson(Map<String, dynamic> json) => TodoRequest(
        title: json["title"],
        description: json["description"],
        completed: json["completed"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "completed": completed,
        "time": time?.toIso8601String(),
      };
}
