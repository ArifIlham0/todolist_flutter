import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:todolist_get/constants/config.dart';
import 'package:todolist_get/models/req/delete_todo_req.dart';
import 'package:todolist_get/models/req/todo_req.dart';
import 'package:todolist_get/models/res/todo_res.dart';
import 'package:todolist_get/utils/export.dart';

class TodoService {
  final Dio dio = Dio();

  Future<List<TodoResponse>> fetchTodos() async {
    String? token = await UserPreferences().getToken();
    print("Token $token");

    final response = await dio.get(
      "$baseUrl/todos",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      var body = todoResponseFromJson(jsonEncode(response.data));
      return body;
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<List<TodoResponse>> fetchOverdueTodos() async {
    String? token = await UserPreferences().getToken();

    final response = await dio.get(
      "$baseUrl/todos/overdue",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      var body = todoResponseFromJson(jsonEncode(response.data));
      return body;
    } else {
      throw Exception('Failed to load overdue todos');
    }
  }

  Future<List<TodoResponse>> fetchCompleteTodos() async {
    String? token = await UserPreferences().getToken();

    final response = await dio.get(
      "$baseUrl/todos/completed",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      var body = todoResponseFromJson(jsonEncode(response.data));
      return body;
    } else {
      throw Exception('Failed to load completed todos');
    }
  }

  Future<bool> createTodo(TodoRequest model) async {
    String? token = await UserPreferences().getToken();

    final response = await dio.post(
      "$baseUrl/todos",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      ),
      data: jsonEncode(model),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create todo');
    }
  }

  Future<bool> updateTodo(String id, TodoRequest model) async {
    String? token = await UserPreferences().getToken();

    final response = await dio.put(
      "$baseUrl/todos/$id",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      ),
      data: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update todo');
    }
  }

  Future<bool> deleteTodo(DeleteTodoRequest model) async {
    String? token = await UserPreferences().getToken();

    final response = await dio.delete(
      "$baseUrl/todos",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      ),
      data: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete todo');
    }
  }
}
