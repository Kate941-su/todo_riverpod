import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TodoListFilter {
  all,
  active,
  completed,
}

final todoListFilterProvider = StateProvider((_) => TodoListFilter.all);