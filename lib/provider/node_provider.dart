import 'package:flutter/foundation.dart';
import 'package:todo_app/data/db_helper.dart';
import 'package:todo_app/models/todo_models.dart';

class NodeProvider extends ChangeNotifier {
  List<NodeModels> _nodeList = [];

  List<NodeModels> get nodeList => _nodeList;

  final DbHelper db = DbHelper.instance;
  NodeProvider(){
    getAllData();

  }

  getAllData() async {
    _nodeList = await db.getAllData();
    notifyListeners();
  }
  getAllCompilitedData() async {
    _nodeList = await db.getAllCompilitedData();
    notifyListeners();
  }

  Future<void> addNode(NodeModels node) async {
    final rowId = await db.insertData(node);
    // node.id = rowId;
    // _nodeList.add(node);
    // // _nodeList = await db.getAllData();
    // notifyListeners();
    await getAllData();
  }

   deletNote(NodeModels node) async {
     await db.deleteTodo(node.id!);
    await getAllData();
  }

  Future<void>upDate( NodeModels node) async{
    await db.updateTodoList(node);

    // final position = _nodeList.indexWhere((element) => element.id == node.id,);
    // _nodeList.removeAt(position);
    // _nodeList.insert(position, node);
    await getAllData();
    // notifyListeners();


  }
}
