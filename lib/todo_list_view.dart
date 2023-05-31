import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_list_provider.dart';

class TodoListView extends ConsumerWidget {
  const TodoListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListState = ref.watch(todoListStateProvider);
    final todoListStateNotifier = ref.watch(todoListStateProvider.notifier);

    return ListView.separated(
      itemCount: todoListState.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(5),
          child: ListTile(
            title: Text(
              todoListState[index].description!,
            ),
            subtitle: Row(
              children: [
                ElevatedButton(
                  child: const Text('delete'),
                  onPressed: () {
                    todoListStateNotifier.delete(todoListState[index]);
                  },
                ),
                ElevatedButton(
                  child: const Text('edit'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: const Text('complete'),
                  onPressed: () {
                    todoListStateNotifier.toggle(todoListState[index].id!);
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
    );
  }
}
