import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/TaskListScreen.dart';
import 'providers/TaskProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider()..loadTasks(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Органайзер',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: TaskListScreen(),
      ),
    );
  }
}