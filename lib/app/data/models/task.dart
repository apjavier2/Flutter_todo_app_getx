class Task {
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
}
