// frozen_string_literal: true

class Todo {
  Todo({
    required this.title,
    required this.datetime
  });

  String title;
  DateTime datetime;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'datetime': datetime.toIso8601String(),
    };
  }
}
