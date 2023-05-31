import 'package:freezed_annotation/freezed_annotation.dart';


part 'todo.freezed.dart';
part 'todo.g.dart';



@freezed
class Todo with _$Todo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Todo({
    String? id,
    String? description,
    @Default(false)
    bool? isCompleted,
}) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}