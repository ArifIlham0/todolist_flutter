import 'dart:convert';

DeleteTodoRequest deleteTodoRequestFromJson(String str) =>
    DeleteTodoRequest.fromJson(json.decode(str));

String deleteTodoRequestToJson(DeleteTodoRequest data) =>
    json.encode(data.toJson());

class DeleteTodoRequest {
  final List<String>? ids;

  DeleteTodoRequest({
    this.ids,
  });

  factory DeleteTodoRequest.fromJson(Map<String, dynamic> json) =>
      DeleteTodoRequest(
        ids: List<String>.from(json["ids"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ids": List<dynamic>.from(ids!.map((x) => x)),
      };
}
