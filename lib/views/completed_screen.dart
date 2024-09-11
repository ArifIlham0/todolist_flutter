import 'package:flutter/material.dart';
import 'package:todolist_get/controllers/export.dart';
import 'package:get/get.dart';
import 'package:todolist_get/models/req/todo_req.dart';
import 'package:todolist_get/theme.dart';
import 'package:todolist_get/components/export.dart';
import 'package:todolist_get/utils/export.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlack,
        centerTitle: true,
        title: Text(
          'Completed',
          style: textStyles(18, kWhite, FontWeight.normal),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Obx(
                () {
                  if (todoController.isLoading.value) {
                    return const Center(child: LoadingIndicator());
                  } else if (todoController.completeTodos.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 200.h),
                        child: Text(
                          'No Task',
                          style: textStyles(16, kWhite, FontWeight.normal),
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: todoController.completeTodos.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final todo = todoController.completeTodos[index];
                          final isSelected =
                              todoController.selectedTodos.contains(todo.id);

                          return TodoList(
                            todos: todo,
                            isSelected: isSelected,
                            isCompleted: true,
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
                            onPressed: () {
                              todoController.updateTodo(
                                todo.id!,
                                TodoRequest(
                                  title: todo.title,
                                  description: todo.description,
                                  time: todo.time,
                                  completed: false,
                                ),
                              );
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
}
