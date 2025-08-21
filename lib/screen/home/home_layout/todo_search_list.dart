import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/todo_models.dart';
import '../../../provider/node_provider.dart';

class TodoSearchList extends SearchDelegate {
  TodoSearchList({required this.titleList});
   List<String> titleList;



  // var noteList = context.read<NodeProvider>().nodeList.where((element) =>element.title == query,);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [ IconButton(onPressed: () {
      query = '';
      showSuggestions(context);
    }, icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {

    List<String> matchQuery = [];
    for ( var searchItem in titleList){
      if(searchItem.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(searchItem);
      }
    }
    return ListView.builder(itemBuilder: (context, index) => ListTile(
      title: Text(matchQuery[index]),
    ),itemCount: matchQuery.length,);
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List<String> matchQuery = [];
    for ( var searchItem in titleList){
      if(searchItem.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(searchItem);
      }
    }
    return ListView.builder(itemBuilder: (context, index) => ListTile(
      title: Text(matchQuery[index]),
    ),itemCount: matchQuery.length,);
  }
}
