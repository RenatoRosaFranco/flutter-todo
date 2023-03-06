// frozen_string_literal: true

import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Adicione uma tarefa',
                    hintText: 'Ex. Estudar flutter',
                  ),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                child: Text('+'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    String text = emailController.text;
    print(text);
  }

  void onChanged(String text) {
    // print(text);
  }

  void onSubmited(String text) {
    print(text);
  }
}