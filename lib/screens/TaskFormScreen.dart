import 'package:flutter/material.dart';
import '../models/Task.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task;

  TaskFormScreen({this.task});

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late String _time;
  bool _isImportant = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task!.title;
      _description = widget.task!.description;
      _time = widget.task!.time;
      _isImportant = widget.task!.isImportant;
    } else {
      _title = '';
      _description = '';
      _time = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? 'Додати' : 'Редагувати')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Назва'),
                onSaved: (value) => _title = value!,
                validator: (value) => value == null || value.isEmpty ? 'Введіть назву' : null,
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Опис'),
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                initialValue: _time,
                decoration: const InputDecoration(labelText: 'Час'),
                onSaved: (value) => _time = value!,
              ),
              SwitchListTile(
                title: const Text('Важливе'),
                value: _isImportant,
                onChanged: (value) => setState(() => _isImportant = value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Зберегти'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final task = Task(
                      id: widget.task?.id,
                      title: _title,
                      description: _description,
                      time: _time,
                      isImportant: _isImportant,
                    );
                    Navigator.pop(context, task);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}