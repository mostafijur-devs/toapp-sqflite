import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_models.dart';

class NodeDetailsPage extends StatelessWidget {
   NodeDetailsPage({super.key, required this.nodeModels});
  
  NodeModels nodeModels;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Node Details'),
      ),
      body: Center(
        child:Text('Title: ${nodeModels.title}\nDescription: ${nodeModels.description}\nDate: ${nodeModels.dateTime}'),
      ),
    );
  }
}
