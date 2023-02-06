import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'task.g.dart';

@JsonSerializable(explicitToJson: true)
class Task extends Equatable{
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? todos;

  const Task(
      {required this.title,
      required this.icon,
      required this.color,
      this.todos});

  /*This task class has a constant keyword so we cannot change the task.
      but we can use this copy with method to create a new instance, then we could
      replace the existing task

      - Used for updating the task
      */

  Task copyWith(
          {String? title, int? icon, String? color, List<dynamic>? todos}) =>
      Task(
          title: title ?? this.title,
          icon: icon ?? this.icon,
          color: color ?? this.color,
          todos: todos ?? this.todos);
  
  factory Task.fromJson(Map<String,dynamic> data) => _$TaskFromJson(data);
  Map<String,dynamic> toJson () => _$TaskToJson(this);
  
  //Equatable. The title, icon, and color will be used to compare it to other instance of this class
  @override
  // TODO: implement props
  List<Object?> get props => [title, icon, color];

}
