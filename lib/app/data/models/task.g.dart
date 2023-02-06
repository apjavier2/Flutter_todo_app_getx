// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      title: json['title'] as String,
      icon: json['icon'] as int,
      color: json['color'] as String,
      todos: json['todos'] as List<dynamic>?,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'title': instance.title,
      'icon': instance.icon,
      'color': instance.color,
      'todos': instance.todos,
    };
