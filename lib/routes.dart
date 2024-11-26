import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_todo_test/screens/home_page.dart';
import 'package:flutter_todo_test/screens/task_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        {
          return MaterialPageRoute(builder: (_) => const HomePage());
        }
      case '/task-page':
        {
          log('Task page');
          return MaterialPageRoute(builder: (_) => TaskListPage());
        }

      default:
        {
          return _errorRoute();
        }
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Page not found',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
        body: Center(
          child: Text(
            'Page does not exist',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      );
    });
  }
}
