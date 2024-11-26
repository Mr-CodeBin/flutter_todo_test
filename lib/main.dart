import 'package:flutter/material.dart';
import 'package:flutter_todo_test/providers/task_provider.dart';
import 'package:flutter_todo_test/routes.dart';
import 'package:flutter_todo_test/utils/theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider()..loadTasks(),
      child: MaterialApp(
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/task-page',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
