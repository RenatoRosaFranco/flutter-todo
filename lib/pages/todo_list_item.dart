// frozen_string_literal: true

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled2/models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[200]
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              DateFormat('dd/MM/yyyy - HH:mm').format(todo.datetime),
              style: const TextStyle(
                fontSize: 12
              ),
            ),
            Text(
                todo.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
            )),
          ]
        ),
      );
  }
}
