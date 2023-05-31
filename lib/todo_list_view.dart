import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_list_provider.dart';

class TodoListView extends ConsumerWidget {
  const TodoListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListIsCompleteState = ref.watch(todoListStateProvider.select((value) {
      return value.map((e) => e.isCompleted).toList();
    }));
    final todoListStateNotifier = ref.watch(todoListStateProvider.notifier);

    return ListView.separated(
      itemCount: todoListIsCompleteState.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(5),
          child: ListTile(
            title: const Text(
              'Fixed',
            ),
            subtitle: Row(
              children: [
                ElevatedButton(
                  child: const Text('delete'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: const Text('edit'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: const Text('complete'),
                  onPressed: () {
                    todoListStateNotifier.toggle(ref.watch(todoListStateProvider.notifier).state[index].id!);
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
