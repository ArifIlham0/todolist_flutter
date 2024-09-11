import 'package:flutter/material.dart';
import 'package:todolist_get/controllers/export.dart';
import 'package:get/get.dart';
import 'package:todolist_get/models/req/todo_req.dart';
import 'package:todolist_get/theme.dart';
import 'package:todolist_get/components/export.dart';
import 'package:todolist_get/utils/export.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoController todoController = Get.put(TodoController());
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  String formattedDateTime = DateTime.now().toUtc().toIso8601String();
  bool isChangeEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlack,
        centerTitle: true,
        title: Text(
          'Task',
          style: textStyles(18, kWhite, FontWeight.normal),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 400.h,
                child: Obx(
                  () {
                    if (todoController.isLoading.value) {
                      return const Center(child: LoadingIndicator());
                    } else if (todoController.todos.isEmpty) {
                      return Center(
                        child: Text(
                          'No Task',
                          style: textStyles(16, kWhite, FontWeight.normal),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: todoController.todos.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final todo = todoController.todos[index];
                          final isSelected =
                              todoController.selectedTodos.contains(todo.id);

                          return TodoList(
                            todos: todo,
                            isSelected: isSelected,
                            onTap: () {
                              if (todoController.isSelectionMode.value) {
                                _toggleSelection(todo.id!);
                                setState(() {});
                              } else {
                                title.text = todo.title!;
                                description.text = todo.description!;
                                modalBottomSheet(
                                  context: context,
                                  todoController: todoController,
                                  todo: todo,
                                  title: title,
                                  description: description,
                                  time: todo.time!,
                                  taskFormKey: todoController.taskFormKey,
                                  onDismiss: clearControllers,
                                  onPressed: () async {
                                    String? dateTime = await todoController
                                        .selectDateTime(context);
                                    if (dateTime != null) {
                                      isChangeEdit = true;
                                      formattedDateTime = dateTime;
                                    }
                                  },
                                  onPressed2: () {
                                    if (todoController.validateForm()) {
                                      todoController.updateTodo(
                                        todo.id!,
                                        TodoRequest(
                                          title: title.text,
                                          description: description.text,
                                          time: isChangeEdit == true
                                              ? DateTime.parse(
                                                  formattedDateTime)
                                              : DateTime.parse(
                                                  todo.time.toString()),
                                          completed: false,
                                        ),
                                      );
                                      clearControllers();
                                      Get.back();
                                      isChangeEdit = false;
                                    }
                                  },
                                );
                              }
                            },
                            onLongPress: () {
                              todoController.isSelectionMode(true);
                              _toggleSelection(todo.id!);
                              setState(() {});
                            },
                            onPressed: () {
                              todoController.updateTodo(
                                todo.id!,
                                TodoRequest(
                                  title: todo.title,
                                  description: todo.description,
                                  time: todo.time,
                                  completed: true,
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: kGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "Overdue",
                        style: textStyles(14, kWhite, FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () {
                  if (todoController.isLoading.value) {
                    return const Center(child: LoadingIndicator());
                  } else if (todoController.overdueTodos.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 45.h),
                        child: Text(
                          'No Task',
                          style: textStyles(16, kWhite, FontWeight.normal),
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: todoController.overdueTodos.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final todo = todoController.overdueTodos[index];
                          final isSelected =
                              todoController.selectedTodos.contains(todo.id);
                          return TodoListOverdue(
                            todos: todo,
                            isSelected: isSelected,
                            onTap: () {
                              if (todoController.isSelectionMode.value) {
                                _toggleSelection(todo.id!);
                                setState(() {});
                              }
                            },
                            onLongPress: () {
                              todoController.isSelectionMode(true);
                              _toggleSelection(todo.id!);
                              setState(() {});
                            },
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          Obx(() {
            if (todoController.isSelectionMode.value) {
              return Positioned(
                bottom: 20.h,
                left: 20.w,
                child: FloatingActionButton(
                  onPressed: () {
                    showCustomDialog(
                      content: "Are you sure want to delete this todo?",
                      onConfirm: () {
                        todoController.deleteSelectedTodos();
                        Get.back();
                      },
                    );
                  },
                  backgroundColor: kRed,
                  child: const Icon(Icons.delete, color: kWhite),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          Positioned(
            bottom: 20.h,
            right: 20.w,
            child: FloatingActionButton(
              onPressed: () {
                modalBottomSheet(
                  context: context,
                  todoController: todoController,
                  title: title,
                  description: description,
                  taskFormKey: todoController.taskFormKey,
                  onDismiss: clearControllers,
                  onPressed: () async {
                    String? dateTime =
                        await todoController.selectDateTime(context);
                    if (dateTime != null) {
                      formattedDateTime = dateTime;
                    }
                  },
                  onPressed2: () {
                    if (todoController.validateForm()) {
                      todoController.addTodo(
                        TodoRequest(
                          title: title.text,
                          description: description.text,
                          time: DateTime.parse(formattedDateTime),
                        ),
                      );
                      clearControllers();
                      Get.back();
                    }
                  },
                );
              },
              backgroundColor: kPurple,
              child: const Icon(Icons.add, color: kWhite),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleSelection(String todoId) {
    if (todoController.selectedTodos.contains(todoId)) {
      todoController.selectedTodos.remove(todoId);
      if (todoController.selectedTodos.isEmpty) {
        todoController.isSelectionMode(false);
      }
    } else {
      todoController.selectedTodos.add(todoId);
    }
  }

  void clearControllers() {
    title.clear();
    description.clear();
    formattedDateTime = DateTime.now().toUtc().toIso8601String();
  }
}
