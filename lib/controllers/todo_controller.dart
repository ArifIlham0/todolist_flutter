import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_get/models/req/delete_todo_req.dart';
import 'package:todolist_get/models/req/todo_req.dart';
import 'package:todolist_get/models/res/todo_res.dart';
import 'package:todolist_get/services/todo_service.dart';

class TodoController extends GetxController {
  var todos = <TodoResponse>[].obs;
  var overdueTodos = <TodoResponse>[].obs;
  var completeTodos = <TodoResponse>[].obs;
  var isLoading = true.obs;
  var selectedTodos = <String>[].obs;
  var isSelectionMode = false.obs;

  final GlobalKey<FormState> taskFormKey = GlobalKey<FormState>();
  final TodoService _todoService = TodoService();

  @override
  void onReady() {
    fetchTodos();
    super.onReady();
  }

  bool validateForm() {
    return taskFormKey.currentState!.validate();
  }

  Future<String?> selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final DateTime finalDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        return finalDateTime.toUtc().toIso8601String();
      }
    }
    return null;
  }

  void deleteSelectedTodos() async {
    if (selectedTodos.isNotEmpty) {
      DeleteTodoRequest deleteRequest =
          DeleteTodoRequest(ids: selectedTodos.toList());

      await deleteTodo(deleteRequest);

      selectedTodos.clear();
      isSelectionMode(false);
      fetchTodos(showLoading: false);
    }
  }

  void fetchTodos({bool showLoading = true}) async {
    if (showLoading) {
      isLoading(true);
    }
    try {
      var fetchedTodos = await _todoService.fetchTodos();
      var fetchedOverdue = await _todoService.fetchOverdueTodos();
      var fetchedComplete = await _todoService.fetchCompleteTodos();
      todos.assignAll(fetchedTodos);
      overdueTodos.assignAll(fetchedOverdue);
      completeTodos.assignAll(fetchedComplete);
    } finally {
      if (showLoading) {
        isLoading(false);
      }
    }
  }

  void addTodo(TodoRequest model) async {
    await _todoService.createTodo(model);
    fetchTodos(showLoading: false);
  }

  void updateTodo(String id, TodoRequest model) async {
    await _todoService.updateTodo(id, model);
    todos.indexWhere((element) => element.id == id);
    fetchTodos(showLoading: false);
  }

  Future<void> deleteTodo(DeleteTodoRequest deleteRequest) async {
    await _todoService.deleteTodo(deleteRequest);
    todos.removeWhere((todo) => deleteRequest.ids!.contains(todo.id));
  }
}
