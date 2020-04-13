import 'package:flutter/material.dart';
import 'package:bnerd/shared/constants.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:bnerd/services/homework_database.dart';

class Addhomework extends StatefulWidget {
  @override
  _AddhomeworkState createState() => _AddhomeworkState();
}

class _AddhomeworkState extends State<Addhomework> {

  final _formKey = GlobalKey<FormState> ();
  String _currentSubject;
  String _currentContent;

  @override
  Widget build(BuildContext context) {

    DateTime _dateTime;
    String dropdownType = 'Homework';

    return KeyboardAvoider(
      autoScroll: true,
      child: Form(
        child: SingleChildScrollView(
            key: _formKey,
            child: Column(
                children: <Widget>[

                  Text(
                    'Create new homework.',
                    style: TextStyle(fontSize: 25.0),
                  ),

                  SizedBox(height: 15.0),
                  ListTile(
                    leading: Icon(Icons.access_time),
                    title: Text(_dateTime == null ? 'select a date': _dateTime.toString()),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2019),
                        lastDate: DateTime(2120),
                      ).then((date) {
                        setState(() {
                          _dateTime = date;
                          print(date);
                        });
                      });
                    }
                  ),

                  //SizedBox(height: 20.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        Icons.category,
                        color: Colors.grey,
                      ),

                      Text('Type'),
                      SizedBox(width: 50.0),
                      DropdownButton<String>(
                        value: dropdownType,
                        icon: Icon(Icons.arrow_downward), iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple), underline: Container(height: 2, color: Colors.deepPurpleAccent, ),
                        onChanged: (String newValue) {
                          setState(() {dropdownType = newValue;});},
                        items: <String>['Homework', 'Test', 'Other'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  ListTile(
                    leading: Icon(Icons.book),
                    //title: Text('Subject',style: TextStyle(fontSize: 15.0),),
                    subtitle: TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Subject'),
                      validator: (val) => val.isEmpty ? 'Please enter a subject' : null,
                      onChanged: (val) => setState(() => _currentSubject = val),
                    ),
                  ),

                  ListTile(
                    leading: Icon(Icons.subject),
                    //title: Text('Content',style: TextStyle(fontSize: 15.0),),
                    subtitle: TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Content'),
                      validator: (val) => val.isEmpty ? 'Please enter a content' : null,
                      onChanged: (val) => setState(() => _currentContent = val),
                    ),
                  ),

                  SizedBox(height: 18.0),
                  RaisedButton(
                    color: Colors.blueGrey[700],
                    child: Text(
                      'Create',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        await HomeworkDataBaseService().createHomeworkData('$_dateTime', '$_currentSubject', '$dropdownType', '$_currentContent');
                        Navigator.pop(context);
                      }
                    },
                  ),
                ]
            )
        ),
      ),
    );
  }
}