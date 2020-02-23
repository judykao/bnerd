import 'package:flutter/material.dart';
import 'package:bnerd/services/homework_database.dart';
import 'package:bnerd/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:bnerd/shared/load.dart';
import 'package:bnerd/model/hw_model.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {

  final _formKey = GlobalKey<FormState> ();
  final List<String> numbers = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40',];

  //form values
  String _currentSubject;
  String _currentContent;
  //String _currentNumber;

  @override
  Widget build(BuildContext context) {

    final homework = Provider.of<Homework>(context);
    DateTime selectedDate = DateTime.now();

    Future<Null> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2020, 2, 21),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        },
      );
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
        });
    }

    String dropdownType = 'Homework';

    return StreamBuilder<HomeworkData>(
        stream: HomeworkDataBaseService(uid: homework.uid).homeworkData,
        builder: (context, snapshot) {
          if(snapshot.hasData){

            HomeworkData homeworkData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your personal file.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  ListTile(
                    leading: Icon(Icons.access_time),
                    title: Text('$selectedDate'),
                      onTap: () => _selectDate(context),
                        //TODO: 寫完讓widget 跑出來但還沒有取值
                  ),
                  ListTile(
                    leading: new Icon(Icons.merge_type),
                    title: new Text('Type'),
                    onTap: () => {
                      DropdownButton<String>(
                        value: dropdownType,
                        icon: Icon(Icons.arrow_downward), iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple), underline: Container(height: 2, color: Colors.deepPurpleAccent, ),
                        onChanged: (String newValue) {
                          setState(() {dropdownType = newValue;});},
                        items: <String>['Homework', 'Test', 'Note'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      //TODO:觸發下拉選單，可以設定類型
                    },
                  ),
                  Row(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.book),
                        title: Text('Subject'),
                      ),
                      TextFormField(
                        initialValue: homeworkData.content,
                        decoration: textInputDecoration.copyWith(),
                        validator: (val) => val.isEmpty ? 'Please enter a subject' : null,
                        onChanged: (val) => setState(() => _currentSubject = val),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.subject),
                        title: Text('Content'),
                      ),
                      TextFormField(
                        initialValue: homeworkData.content,
                        decoration: textInputDecoration.copyWith(),
                        validator: (val) => val.isEmpty ? 'Please enter a subject' : null,
                        onChanged: (val) => setState(() => _currentContent = val),
                      ),
                    ],
                  ),
                  RaisedButton(
                    color: Colors.blueGrey[700],
                    child: Text(
                      'Create',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        await HomeworkDataBaseService().createHomeworkData('$selectedDate', '$_currentSubject', '$dropdownType', '$_currentContent', 'note');
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        }
    );
  }
}

