import 'package:flutter/cupertino.dart';

const tableTodo = 'tbl_todo';
const tableTodoColumId = 'id';
const tableTodoColumDescription = 'description';
const tableTodoColumTitle = 'title';
const tableTodoColumDatetime = 'dateTime';
const tableTodoColumIsDone = 'isDone';

class NodeModels {
  int? id;
  String description;
  String title;
  DateTime dateTime;
  bool isDone;

  NodeModels({
    this.id,
    required this.description,
    required this.title,
    required this.dateTime,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      tableTodoColumId: id,
      tableTodoColumDescription: description,
      tableTodoColumTitle: title,
      tableTodoColumDatetime: dateTime.toIso8601String(),
      tableTodoColumIsDone: isDone ? 1 : 0,
    };
  }

  factory NodeModels.fromMap(Map<String, dynamic> map){
    return NodeModels(
      id: map[tableTodoColumId],
      title: map[tableTodoColumTitle],
      description: map[tableTodoColumDescription],
      dateTime: DateTime.parse(map[tableTodoColumDatetime]),
      isDone: map[tableTodoColumIsDone] == 1,
    );
  }
}

