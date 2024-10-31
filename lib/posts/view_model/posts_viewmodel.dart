import '../../base/base_state.dart';
import '../../base/base_viewmodel.dart';
import '../../base/base_state_provider.dart';
import '../repository/todoRepo_repository.dart';
import '../repository/model/todo_response.dart';

final todoViewModelProvider = BaseStateProvider<TodoViewState, PostsViewModel>(
    (ref) => PostsViewModel(ref.watch(taskRepoProvider)));

class TodoViewState {
  List<Todo> todo = [];

  TodoViewState(this.todo);
}

class PostsViewModel extends BaseViewModel<TodoViewState> {
  final TodoRepo repo;

  PostsViewModel(this.repo) : super(BaseState(data: null));

  fetchTask() async {
    try {
      final response = await repo.getAllTodos();
      data = TodoViewState(response);
    } catch (e) {
      isLoad = false;
      error = BaseError(e.toString());
    }
  }

  //add a new todo to database
  Future<void> addTask(Todo todo) async {
    try {
      isLoad = true;
      Todo newTask = Todo(
          id: todo.id,
          task: todo.task,
          description: todo.description,
          isComplated: todo.isComplated);
      await repo.addTodo(newTask);
      isLoad = false;
      await fetchTask();
    } catch (e) {
      isLoad = false;
      error = BaseError(e.toString());
    }
  }

  //update an existing todo
  Future<void> updateTodo(Todo todo) async {
    try {
      isLoad = true;
      await repo.updateTodo(todo);
      await fetchTask();
    } catch (e) {
      //isLoad = false;
      print(e);
    }
  }

  //delete
  Future<void> deleteTodoById(String id) async {
    try {
      await repo.deleteToDoById(int.parse(id));
      await fetchTask();
    } catch (e) {
      print(e);
    }
  }
}
