import 'package:bnerd/model/hw_model.dart';
import 'package:flutter/material.dart';
import 'package:bnerd/model/homework.dart';


class HomeworkTile extends StatelessWidget {

  final HomeworkData homework;
  HomeworkTile({this.homework});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.amber,
          ),
          subtitle: Text(homework.subject),
          title: Text(homework.content),
          onTap: (){

          },
        ),
      ),
    );
  }
}
