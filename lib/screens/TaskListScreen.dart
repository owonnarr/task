import 'package:flutter/material.dart';
import '../db/TaskDb.dart';
import '../models/Task.dart';
import 'TaskFormScreen.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final fetchedTasks = await Taskdb.instance.getTasks();
    setState(() {
      tasks = fetchedTasks;
    });
  }

  void _addTask() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskFormScreen()),
    );
    if (newTask != null) {
      await Taskdb.instance.insertTask(newTask);
      _loadTasks();
    }
  }

  void _editTask(Task task) async {
    final updatedTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskFormScreen(task: task),
      ),
    );
    if (updatedTask != null) {
      await Taskdb.instance.updateTask(updatedTask);
      _loadTasks();
    }
  }

  void _deleteTask(int id) async {
    await Taskdb.instance.deleteTask(id);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Органайзер')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            color: task.isImportant ? Colors.deepPurple[100] : Colors.white,
            child: ListTile(
              title: Text(
                  task.title,
                  style: const TextStyle(
                      fontWeight:
                      FontWeight.bold,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                  )
              ),
              subtitle: Text('${task.description}\n${task.time}'),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editTask(task),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTask(task.id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}