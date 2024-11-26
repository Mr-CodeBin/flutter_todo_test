import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_todo_test/models/task_model.dart';
import 'package:flutter_todo_test/providers/task_provider.dart';

import 'package:provider/provider.dart';

class TaskListPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: custAppBar(context, isDark),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                custTextFIeld(context),
                const SizedBox(height: 8),
                custElevatedBtn(context, taskProvider),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];

                return custListTile(task, taskProvider, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar custAppBar(BuildContext context, bool isDark) {
    return AppBar(
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //ask for confirmation before leaving the page
            confirmDialogBox(context);
          }),
      centerTitle: true,
      title: const Text(
        'Your Tasks',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.only(left: 4, right: 20),
          decoration: BoxDecoration(
            color: (isDark) ? Colors.black38 : Colors.white54,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  (isDark) ? Icons.nightlight_round : Icons.light_mode_rounded,
                ),
                onPressed: () {},
              ),
              Text((isDark) ? 'Dark' : 'light',
                  style: const TextStyle(
                    fontSize: 12,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Padding custListTile(TaskModel task, TaskProvider taskProvider, int index) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        tileColor: (task.isDone)
            ? const Color(0xFF2EAB57).withOpacity(0.2)
            : Colors.transparent,
        leading: Checkbox(
          value: task.isDone,
          onChanged: (_) => taskProvider.markAsDone(index),
        ),
        title: Text(
          task.title,
          // "loraeaasjhdvasjfvajgfvasjhfvasjhfvasjhfvasfjhasdvfjhasdvfjhasvfajshvfasjlf",
          style: TextStyle(
            fontSize: 18,
            decoration:
                task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            taskProvider.deleteTask(index);
          },
        ),
      )
          .animate(target: task.deleted ? 0 : 1)
          .move(
              begin: const Offset(0, 10),
              end: const Offset(0, 0),
              curve: Curves.easeIn)
          .fadeIn(),
    );
  }

  ElevatedButton custElevatedBtn(
      BuildContext context, TaskProvider taskProvider) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 0),
        shadowColor: Colors.black, // Shadow color
        elevation: 5, // Elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: () {
        if (_controller.text.isNotEmpty) {
          taskProvider.addTask(TaskModel(title: _controller.text));
          _controller.clear();
          FocusScope.of(context).unfocus();
        }
      },
      child: const Text(
        'Add',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  TextField custTextFIeld(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Add a task',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 135, 179, 150),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 135, 179, 150),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color(0xFF2EAB57),
          ),
        ),
        prefixIcon: Icon(
          Icons.abc_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Future<dynamic> confirmDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
            'All unsaved changes will be lost.\nDo you want to leave?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              exit(0);
            },
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }
}
