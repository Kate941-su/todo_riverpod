import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/todo_list_provider.dart';
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
    ref.watch(todoListStateProvider);
    final todoListStateNotifier = ref.watch(todoListStateProvider.notifier);
    final uncompletedTodosCountState = ref.watch(uncompletedTodosCount);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('The remaining tasks $uncompletedTodosCountState')),
        body: Center(
          child: ListView.separated(
            itemCount: ref.read(todoListStateProvider.notifier).state.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(5),
                child: ListTile(
                  title: Text(
                    '${ref.read(todoListStateProvider.notifier).state[index].description}',
                  ),
                  subtitle: Row(
                    children: [
                      ElevatedButton(
                        child: const Text('delete'),
                        onPressed: () {
                          todoListStateNotifier.delete(ref
                              .read(todoListStateProvider.notifier)
                              .state[index]);
                        },
                      ),
                      ElevatedButton(
                        child: const Text('edit'),
                        onPressed: () {},
                      ),
                      ElevatedButton(
                        child: const Text('complete'),
                        onPressed: () {
                          todoListStateNotifier.toggle(ref
                              .read(todoListStateProvider.notifier)
                              .state[index]
                              .id!);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 0.5,
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            todoListStateNotifier.add(description: "hello!");
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
