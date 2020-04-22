import 'package:bnerd/model/hw_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bnerd/model/homework.dart';
import 'package:provider/provider.dart';
import 'package:bnerd/services/homework_database.dart';


class HomeworkList extends StatefulWidget {

  // final HW homework;
  // HomeworkList({this.homework});
  @override
  _HomeworkListState createState() => _HomeworkListState();
}

class _HomeworkListState extends State<HomeworkList> {
  //final homeworkdata = Firestore.instance;


  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('homework')
            .document('1')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          } else {
            Map<String, dynamic> documentFields = snapshot.data.data;
               return Material(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.book),
                        title: Text('Homework1'),
                        subtitle: Column(
                          children: <Widget>[
                            Text('$documentFields')
                          ],
                        ),
                        //trailing: Icon(Icons.dehaze),
                        isThreeLine: true,
                        //selected: true,
                      ),
                    ],
                  ),
                );
             }
          }
        );
  }
}


