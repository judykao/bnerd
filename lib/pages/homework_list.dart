import 'package:bnerd/pages/homework_tile.dart';
import 'package:flutter/material.dart';
import 'package:bnerd/model/hw_model.dart';
import 'package:provider/provider.dart';


class HomeworkList extends StatefulWidget {
  @override
  _HomeworkListState createState() => _HomeworkListState();
}

class _HomeworkListState extends State<HomeworkList> {
  @override
  Widget build(BuildContext context) {

    final homeworks = Provider.of<List<HomeworkData>>(context) ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Homework'),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          itemCount: homeworks.length,
          itemBuilder: (context, index){
            return HomeworkTile(homework: homeworks[index]);
          },
        ),
      ),
    );
  }
}


