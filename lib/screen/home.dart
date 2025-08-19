import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/heiper_function.dart';
import 'package:todo_app/models/todo_models.dart';
import 'package:todo_app/provider/node_provider.dart';
import 'package:todo_app/screen/add_todo_screen.dart';
import 'package:todo_app/screen/update_task_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   int _correntIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<NodeProvider>().getAllData();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    context.read<NodeProvider>().getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        centerTitle: true,
        backgroundColor: Colors.blue.withOpacity(0.5),
      ),
      body: Consumer<NodeProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemBuilder: (context, index) {
            final nodeList = provider.nodeList[index];
            return ListTile(
              leading: Checkbox(
                onChanged: (value) {
                  // context.read<NodeProvider>().upDate(nodeList);
                  nodeList.isDone = value!;
                  context.read<NodeProvider>().upDate(nodeList);
                },
                value: nodeList.isDone,
              ),
              title: Text(nodeList.title),
              subtitle: Text(nodeList.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Text('Date'),
                      Text(
                            dateFormat(nodeList.dateTime, pattran: 'dd-MM-yyy')!,
                            style: TextStyle(fontSize: 16),
                          ),
                    ],
                  ),
                  SizedBox(width: 30,),
                  PopupMenuButton(itemBuilder: (context) {
                    return [
                      PopupMenuItem(child: Text('Edit'),onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateTaskScreen(nodeModels: nodeList),
                          ),
                        );
                      }),
                      PopupMenuItem(child: Text('delete'),onTap: (){
                        context.read<NodeProvider>().deletNote(nodeList);
                      }),

                    ];
                  } ,),
                ],
              ),

              // trailing: Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     Text(
              //       dateFormat(nodeList.dateTime, pattran: 'dd-MM-yyy')!,
              //       style: TextStyle(fontSize: 16),
              //     ),
              //     SizedBox(width: 50),
              //     InkWell(
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) =>
              //                 UpdateTaskScreen(nodeModels: nodeList),
              //           ),
              //         );
              //       },
              //       child: Icon(Icons.edit),
              //     ),
              //     SizedBox(width: 10),
              //     InkWell(
              //       onTap: () {
              //         // provider.deletNote(provider.nodeList[index]);
              //         context.read<NodeProvider>().deletNote(nodeList);
              //       },
              //       child: Icon(Icons.delete),
              //     ),
              //   ],
              // ),
            );
          },
          itemCount: provider.nodeList.length,
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTodoScreen(),
          );
        },
        child: Text('Add Task'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _correntIndex = value;
            if(_correntIndex == 0){
              context.read<NodeProvider>().getAllData();
            }
             if(_correntIndex == 1){
               context.read<NodeProvider>().getAllCompilitedData();
             }

          });

        },
        currentIndex: _correntIndex,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'All Node'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Completed Node'),
        ],
      ),
    );
  }
}
