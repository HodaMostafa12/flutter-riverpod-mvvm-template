import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvvm_template/base/base_appbar.dart';
import 'package:riverpod_mvvm_template/base/base_scaffold.dart';
import 'package:riverpod_mvvm_template/posts/view_model/posts_viewmodel.dart';
import 'package:riverpod_mvvm_template/util/task_dialogs.dart';
// import 'package:riverpod_mvvm_template/util/environment.dart';
import '../repository/model/todo_response.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<Home> {
  final ShowAppDialog dialog = ShowAppDialog();
  List<Todo> todo = [];
    final List<Color> taskColors = [
    Colors.amber.shade400,
    Colors.amber.shade200,
    Colors.amber.shade300,
    Colors.amber.shade100,
    Colors.orange.shade100,
    Colors.orange.shade200,
    Colors.orange.shade400,
    Colors.orange.shade300,
  ];

  Color randomColorTask(int index) {
    return taskColors[index % taskColors.length];
  }

  @override
  void initState() {
    super.initState();
      Future.delayed(Duration.zero, () {
      ref.read(todoViewModelProvider.notifier).fetchTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    todo = ref.watch(todoViewModelProvider).data?.todo ?? [];
    return BaseScaffold(
      appBar: baseAppBar(context, 'tittle'),
      viewModel: todoViewModelProvider,
      body: todo.isNotEmpty ? GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 170),
        itemCount: todo.length,
        itemBuilder: (context, index) {
          final task = todo[index];
          final color = randomColorTask(index);
       return Padding(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    width: 180,
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: color,
                          ),
          child:  Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              title: Text(task.task),
              subtitle: Text(task.description),
              trailing: Checkbox(
                value: task.isComplated,
                onChanged: (value) {
                  ref.read(todoViewModelProvider.notifier).updateTodo(
                        Todo(
                          id: task.id,
                          task: task.task,
                          description: task.description,
                          isComplated: value ?? false,
                        ),
                      );
                },
              ),
            ),
          ),
         ), 
           Positioned(
                            top: 10,
                            right: 10,
                            child: PopupMenuButton<String>(
                              color: Colors.grey.shade300,
                              icon: const Icon(Icons.more_vert),
                              onSelected: (value) {
                                if (value == 'Edit') {
                                  dialog.EditDialog(context,ref, task);
                                  ref.watch(todoViewModelProvider).data?.todo;
                                } else if (value == 'Delete') {
                                  dialog.showDeleteDialog(context,ref, task);
                                  ref.watch(todoViewModelProvider).data?.todo;
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'Edit',
                                  child: Text('Edit'),
                                ),
                                const PopupMenuItem(
                                  value: 'Delete',
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          ), ]  )));
                  
        },
      ) : const Center(child : Text('No Tasks Added until now')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade400,
        onPressed: () {
        dialog.showAddDialog(context, ref);
      },
      child: const Icon(Icons.add,color: Colors.black,),
      ),  
    );
  }
}
