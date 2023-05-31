import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/todo_list_provider.dart';
import 'todo_list_filter_provider.dart';
import 'uncompletedTodosCount.dart';
import 'todo_list_filter_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListState = ref.watch(todoListStateProvider.notifier);
    final uncompletedTodosCountState = ref.watch(uncompletedTodosCount);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('The remaining tasks $uncompletedTodosCountState')),
        body: Center(
          child: ListView.separated(
            itemCount: todoListState.state.length,
            itemBuilder: (context, index) {
              return Container(
                  padding: const EdgeInsets.all(5),
                  child: ListTile(
                    title: Text(
                      '${todoListState.state[index].description!}',
                    ),
                    subtitle: Row(
                      children: [
                        ElevatedButton(
                          child: Text('delete'),
                          onPressed: () {
                            todoListState.delete(todoListState.state[index]);
                          },
                        ),
                        ElevatedButton(
                          child: Text('edit'),
                          onPressed: () {},
                        ),
                        ElevatedButton(
                          child: Text('complete'),
                          onPressed: () {
                            todoListState.toggle(todoListState.state[index].id!);
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
           todoListState.add(
               description: "hello!"
           );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
