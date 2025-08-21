import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screen/home/home_layout/update_task_screen.dart';
import '../../../heiper_function.dart';
import '../../../provider/node_provider.dart';

class TodoBody extends StatelessWidget {
  TodoBody({
    super.key,
    required this.provider,
  });
  NodeProvider provider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
        );
      },
      itemCount: provider.nodeList.length,
    );
  }
}