import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/models/todo_models.dart';

class DbHelper {
  DbHelper._();
  Database? _database;
  static get instance => DbHelper._();

 Future<Database>  checkDatabase () async {
    if (_database != null) {
      return _database!;
    }
    return await openDb();
  }

  final createTableQuary = '''create table $tableTodo(
$tableTodoColumId integer primary key autoincrement,
$tableTodoColumTitle text,
$tableTodoColumDescription text,
$tableTodoColumDatetime text,
$tableTodoColumIsDone integer)
''';

  Future<Database> openDb() async {
    final rootPath = await getApplicationDocumentsDirectory();
    final pathFile = await path.join(rootPath.path, 'todo.db');
  return  await openDatabase(
      pathFile,
      version: 1,
      onCreate: (db, version) {
        db.execute(createTableQuary);
      },
    );
  }
  Future<int> insertData(NodeModels node) async{
    final db =  await checkDatabase();
    return await db.insert(tableTodo, node.toMap());
  }
  
 Future<int> deleteTodo (int id)async{
    final db = await checkDatabase();
    return await db.delete(tableTodo,where:'$tableTodoColumId = ?',whereArgs: [id]);
  }

 Future<int> updateTodoList (NodeModels node) async{
    final db = await checkDatabase();
    return await db.update(tableTodo, node.toMap() ,where: '$tableTodoColumId = ?', whereArgs: [node.id] );
  }
  updateStatus(NodeModels node) async{
    final db = await checkDatabase();

    return await db.update(tableTodo, node.toMap(), where: '$tableTodoColumId = ?', whereArgs: [node.id]);
  }

  Future< List<NodeModels>>getAllData() async{
    final db = await checkDatabase();
    final dataList = await db.query(tableTodo,orderBy:'$tableTodoColumIsDone ASC' );
    return List.generate(dataList.length, (index) => NodeModels.fromMap( dataList[index])).toList();
  }
  Future< List<NodeModels>>getAllCompilitedData() async{
    final db = await checkDatabase();
    final dataList = await db.query(tableTodo,where: '$tableTodoColumIsDone = ?',whereArgs: [1]);
    return List.generate(dataList.length, (index) => NodeModels.fromMap( dataList[index])).toList();
  }

  Future<List<NodeModels>>getCompilitedTask()async{
    final db = await checkDatabase();
    final isDoneList = await db.query(tableTodo, where: '$tableTodoColumIsDone = ?',whereArgs: [1]);
    return List.generate(isDoneList.length, (index) => NodeModels.fromMap(isDoneList[index]),);
  }

  Future<List<NodeModels>>getUnCompilitedTask() async{
    final db = await checkDatabase();
    final unCompilitedTaskList = await db.query(tableTodo,where: '$tableTodoColumIsDone = ?',whereArgs: [0]);
    return List.generate(unCompilitedTaskList.length, (index) => NodeModels.fromMap(unCompilitedTaskList[index]),);
  }
}
