import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/heiper_function.dart';
import 'package:todo_app/models/todo_models.dart';
import 'package:todo_app/provider/node_provider.dart';

class AddTodoScreen extends StatefulWidget {
   AddTodoScreen({super.key,});
  // NodeModels nodeModels;

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _titleController = TextEditingController();
  final _descriptionCOntroller = TextEditingController();
  DateTime? selectedDate;

  // final _dateTimeCOntroller = TextEditingController();
  // final _piorityCOntroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _titleController.clear();
    _descriptionCOntroller.clear();
    selectedDate = null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _titleController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(20),
                  // borderSide: BorderSide(width: 1, color: Colors.black),
                ),
                labelText: 'Enter your title',
                hintText: 'Please input text',
                // errorText: ''
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title is empty';
                } else if (value.length < 3) {
                  return 'Title must be at least 3 characters';
                }
                return null;
              },
            ),
            SizedBox(height: 15),
            TextFormField(
              keyboardType: TextInputType.text,

              controller: _descriptionCOntroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(20),
                  // borderSide: BorderSide(width: 1, color: Colors.black),
                ),
                labelText: 'Enter your description',
                hintText: 'Please input text',
                // errorText: ''
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'description is empty';
                } else if (value.length < 3) {
                  return 'description must be at least 3 characters';
                }
                return null;
              },
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text('Please select a date'),
                TextButton(
                  onPressed: () {
                    _selectDatePicker();
                  },
                  child: Text(
                    selectedDate == null
                        ? 'No date selected'
                        : dateFormat(selectedDate)!,
                  ),
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () async {

                if (formKey.currentState!.validate()  ) {

                  final node =   NodeModels(
                    description: _descriptionCOntroller.text,
                    title: _titleController.text,
                    isDone: false,
                    dateTime: selectedDate!,
                  );
                  context.read<NodeProvider>().addNode(node);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task add successful')));
                  Navigator.pop(context);
                  print('save data');

                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _descriptionCOntroller.dispose();
    selectedDate = null;
  }
  Future<void> _selectDatePicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }
}
