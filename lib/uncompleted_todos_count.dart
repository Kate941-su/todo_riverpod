import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/todo_list_provider.dart';

final uncompletedTodosCount = Provider<int>((ref) {
  return ref.watch(todoListStateProvider).where((todo) => (todo.isCompleted == false)).length;
});