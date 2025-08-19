import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/db_helper.dart';
import 'package:todo_app/heiper_function.dart';
import 'package:todo_app/models/todo_models.dart';
import 'package:todo_app/provider/node_provider.dart';

class UpdateTaskScreen extends StatefulWidget {
  UpdateTaskScreen({super.key, required this.nodeModels});

  final NodeModels nodeModels;

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionCOntroller = TextEditingController();
  DateTime? selectedDate;
  final DbHelper db = DbHelper.instance;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.nodeModels.title);
    _descriptionCOntroller = TextEditingController(
      text: widget.nodeModels.description,
    );
    selectedDate = widget.nodeModels.dateTime;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _descriptionCOntroller.dispose();
    selectedDate = null;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  updateTask() async {
    if (formKey.currentState!.validate()) {
      final updateNode = NodeModels(
        id: widget.nodeModels.id,
        description: _descriptionCOntroller.text,
        title: _titleController.text,
        dateTime: selectedDate!,
        isDone: false,
      );
     // await db.updateTodoList(updateNode);
      context.read<NodeProvider>().upDate(updateNode);
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update successful')));
     Navigator.pop(context);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update to task')),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
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


              // ElevatedButton(
              //   onPressed: () async {
              //     if (formKey.currentState!.validate()) {
              //       context
              //           .read<NodeProvider>()
              //           .addNode(
              //             NodeModels(
              //               description: _descriptionCOntroller.text,
              //               title: _titleController.text,
              //               isDone: false,
              //               dateTime: selectedDate!,
              //             ),
              //           )
              //           .then((value) {
              //             Navigator.pop(context);
              //             print('save data');
              //           });
              //     }
              //   },
              //   child: Text('Save'),
              // ),
              ElevatedButton(
                onPressed: updateTask,
                child: Text('UpDate'),
              ),
              Spacer(),

            ],
          ),
        ),
      ),
    );
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
