// frozen_string_literal: true

import 'package:flutter/material.dart';
import 'package:untitled2/pages/todo_list_item.dart';
import 'package:untitled2/models/todo.dart';
import 'package:untitled2/repositories/todo_repository.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController taskController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  List<Todo> todos = [];

  Todo? deletedTodo;
  int? deletedTodoPos;

  String? errorText;

  @override
  void initState() {
    super.initState();

    todoRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: taskController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Adicione uma tarefa',
                          hintText: 'Ex. Estudar flutter',
                          errorText: errorText,
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff00d7f3),
                              width: 2
                            ),
                          ),
                          labelStyle: const TextStyle(
                            color: Color(0xff00d7f3)
                          )
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        String text = taskController.text;

                        if(text.isEmpty) {
                          setState(() {
                            errorText = 'O titulo n??o pode ser vazio!';
                          });
                          return;
                        }

                        setState(() {
                          Todo newTodo =
                              Todo(title: text, datetime: DateTime.now());

                          todos.add(newTodo);
                          errorText = null;
                        });

                        taskController.clear();
                        todoRepository.saveTodoList(todos);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff00d7f3),
                          padding: const EdgeInsets.all(14)),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                            todo: todo,
                            onDelete: onDelete
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                            'Voc?? possui ${todos.length} tarefas pendentes')),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: showDeleteTodosConfirmationDialog,
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff00d7f3),
                          padding: const EdgeInsets.all(14)),
                      child: const Text('Limpar Tudo'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Limpar Tudo?', textAlign: TextAlign.center),
              content: const Text(
                  'Voc?? tem certeza que deseja apagar todas as tarefas?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      primary: const Color(0xff00d7f3)
                    ),
                    child: const Text(
                        'Cancelar'
                    )
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    deleteAllTodos();
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.red
                  ),
                  child: const Text(
                    'Limpar Tudo'
                  ),
                ),
              ],
            ));
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });
    todoRepository.saveTodoList(todos);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tarefa ${todo.title} foi removida com sucesso.',
      style: const TextStyle(
        color: Color(0xff060708)
      ),),
      backgroundColor: Colors.white,
      action: SnackBarAction(
        label: 'Desfazer',
        textColor: const Color(0xff00d7f3),
        onPressed: () {
          setState(() {
            todos.insert(deletedTodoPos!, deletedTodo!);
          });
          todoRepository.saveTodoList(todos);
        },
      ),
      duration: const Duration(seconds: 5)),
    );
  }

  void deleteAllTodos() {
    setState(() {
      todos.clear();
    });

    todoRepository.saveTodoList(todos);
  }
}
