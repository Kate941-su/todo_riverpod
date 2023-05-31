import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final todoListStateProvider =
    StateNotifierProvider<TodoListStateNotifier, List<Todo>>((ref) {
  return TodoListStateNotifier([
    Todo(id: 'todo-1', description: 'first'),
    Todo(id: 'todo-2', description: 'second'),
    Todo(id: 'todo-3', description: 'third'),
  ]);
});

class TodoListStateNotifier extends StateNotifier<List<Todo>> {
  TodoListStateNotifier(List<Todo>? initialTodos) : super(initialTodos ?? []);

  // Todoリストに追加する
  // ステート自体もイミュータブルのため、state.add(todo)のような操作はできない
  void add({required String description}) {
    final id =_uuid.v4();
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        description: description + id,
      ),
    ];
  }

  // Todoリストを編集する
  void edit({required String description, required String id}) {
    // リスト内特殊記法
    // イミュータブルのため一回stateを作り直す必要がある
    state = [
      for (final todo in state)
        if (todo.id == id) // 編集したい記事のidと一致したとき
          Todo(
            id: todo.id,
            isCompleted: todo.isCompleted,
            description: description,
          ) else
            todo,
    ];
  }

  // Todoリストから削除する
  void delete(Todo target) {
    // 指定したtodo以外のものをstateにする。
    state = state.where((todo) => todo.id != target.id).toList();
  }

  // Todoリストの状態をトグルする
  void toggle(String id) {
    state = [
      for (final todo in state)
        if(todo.id == id)
          Todo(
            id: todo.id,
            description: todo.description,
            isCompleted: todo.isCompleted == true ? false : true,
          ) else
            todo,
    ];
  }
}
