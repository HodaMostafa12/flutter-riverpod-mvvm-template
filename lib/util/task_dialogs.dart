import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvvm_template/util/custum_textcontroller.dart';

import '../posts/repository/model/todo_response.dart';
import '../posts/repository/todoRepo_repository.dart';
import '../posts/view_model/posts_viewmodel.dart';
import 'custum_text_field.dart';


class ShowAppDialog {
  final _formkey = GlobalKey<FormState>();

  void showAddDialog(BuildContext context, WidgetRef ref) {
    // final taskeController = TextEditingController();
    // final describtion = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.amber,
            title: Text(
              'Add Task',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            content: Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    fieldForm(label: 'Enter your Task', controller: task),
                    const SizedBox(
                      height: 10,
                    ),
                    fieldForm(
                        label: 'Enter your describtion',
                        controller: description),
                  ],
                )),
            actions: [
              TextButton(
                child: Text(
                  'save',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                onPressed: () async {
                  String _task = task.text;
                  String _describtion = description.text;
                  if (_task.isNotEmpty || _describtion.isNotEmpty) {
                    final newTodo = Todo(
                      task: _task,
                      description: _describtion,
                      isComplated: false,
                    );
                    await ref.read(todoViewModelProvider.notifier).addTask(newTodo);
                    Navigator.of(context).pop();
                  } else {
                    print("#########################there is error");
                  }
                },
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).context;
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  )),
            ],
          );
        });
  }

  void EditDialog(BuildContext context, WidgetRef ref, Todo todo) {
    showDialog(
        context: context,
        builder: (context) {
          return Form(
              child: AlertDialog(
            backgroundColor: Colors.amber.shade400,
            title: Text(
              'Edit your task',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                fieldForm(label: 'Edit task', controller: task),
                const SizedBox(
                  height: 10,
                ),
                fieldForm(
                  label: 'Edit descreiption',
                  controller: description,
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  String _task = task.text;
                  String _description = description.text;
                  if (_task.isNotEmpty || _description.isNotEmpty) {
                    final newTodo = Todo(
                      task: _task,
                      description: _description,
                      isComplated: false,
                    );
                    await ref.read(todoViewModelProvider.notifier).addTask(newTodo);
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'Update',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              )
            ],
          ));
        });
  }

  void showDeleteDialog(BuildContext context, WidgetRef ref, Todo todo) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.amber.shade400,
            title: Text(
              'Delete this task',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text('do you want to delete this task?!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'cancel',
                    style: TextStyle(color: Colors.blue),
                  )),
              TextButton(
                  onPressed: () async {
                    String _task = task.text;
                    String _description = description.text;
                    final newTodo = Todo(
                      task: _task,
                      description: _description,
                      isComplated: false,
                    );
                    await ref.read(todoViewModelProvider.notifier).addTask(newTodo);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'delete',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }
}
