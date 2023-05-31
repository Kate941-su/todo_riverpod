import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/todo_list_provider.dart';
import 'package:todo_riverpod/todo_list_view.dart';
import 'uncompleted_todos_count.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 下のコードではローカル変数が使用されていない警告が出るが、引数なしのwatchはあり？
    // final todoListState = ref.watch(todoListStateProvider);
    final uncompletedTodosCountState = ref.watch(uncompletedTodosCount);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('The remaining tasks $uncompletedTodosCountState')),
        body: const Center(
          child: TodoListView(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.watch(todoListStateProvider.notifier).add(description: "");
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
