
import 'package:bnerd/shared/load.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeworkList extends StatefulWidget {

  @override
  _HomeworkListState createState() => _HomeworkListState();
}

class _HomeworkListState extends State<HomeworkList> {

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('homework')
            .document('1')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            Map<String, dynamic> documentFields = snapshot.data.data;
               return Scaffold(
                 appBar: AppBar(
                   title: Text('Homeworks'),
                   backgroundColor: Color(0xff4598a2),
                 ),
                 body:Container(
                   padding: EdgeInsets.all(10.0),
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
                         isThreeLine: true,
                         //selected: true,
                       ),
                     ],
                   ),
                 ),
               );
             }
          }
        );
  }
}


