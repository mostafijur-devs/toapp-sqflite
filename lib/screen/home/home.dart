import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/node_provider.dart';
import 'package:todo_app/screen/home/home_layout/add_todo_screen.dart';
import 'home_layout/todo_body.dart';
import 'home_layout/todo_search_list.dart';

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
        actions: [
          IconButton(onPressed: () {
            List<String> nodeList = context.read<NodeProvider>().nodeList.map((e) => e.title,).toList();
            showSearch(context: context, delegate: TodoSearchList(titleList:nodeList ));
          }, icon: Icon(Icons.search_rounded))

        ],
      ),
      body: Consumer<NodeProvider>(
        builder: (context, provider, child) =>
            TodoBody(provider: provider),
      ),

      //********** floatingActionButton section ***************

      floatingActionButton: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) =>
                AddTodoScreen(),
          );
        },
        child: Text('Add Task'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _correntIndex = value;
            if (_correntIndex == 0) {
              context.read<NodeProvider>().getAllData();
            }
            if (_correntIndex == 1) {
              context.read<NodeProvider>().getAllCompilitedData();
            }
          });
        },
        currentIndex: _correntIndex,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'All Node'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Completed Node',
          ),
        ],
      ),
    );
  }
}
