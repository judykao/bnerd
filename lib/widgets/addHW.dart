import 'package:flutter/material.dart';
import 'package:bnerd/shared/constants.dart';

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


    //  Widget buildScrollView() {

    //   return  SingleChildScrollView(
    //       scrollDirection: Axis.vertical,
    //       reverse: false,
    //       padding: EdgeInsets.all(0.0),
    //       physics: BouncingScrollPhysics(),
    //       child: Center(
    //         child: Column(
    //           children: <Widget>[
    //             Container(color: Colors.white ,margin: EdgeInsets.only(top: 10),height: 440,),
    //             Container(color: Colors.green ,margin: EdgeInsets.only(top: 10),height: 540,),
    //           ],
    //         ),
    //       ),
    //   );
    // }


    return Form(
      child: SingleChildScrollView(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Text(
                  'Create new homework.',
                  style: TextStyle(fontSize: 16.0),
                ),

                SizedBox(height: 15.0),
                ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text('$selectedDate'),
                  onTap: () => _selectDate(context),
                  //todo: 寫完讓widget 跑出來但還沒有取值
                ),

                SizedBox(height: 20.0),
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
                      items: <String>['Homework', 'Test', 'Other'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    //todo:觸發下拉選單，可以設定類型
                  },
                ),

                ListTile(
                  leading: Icon(Icons.book),
                  title: Text('Subject',style: TextStyle(fontSize: 15.0),),
                  subtitle: TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Subject'),
                    validator: (val) => val.isEmpty ? 'Please enter a subject' : null,
                    onChanged: (val) => setState(() => _currentSubject = val),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.subject),
                  title: Text('Content',style: TextStyle(fontSize: 15.0),),
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
                      await HomeworkDataBaseService().createHomeworkData('$selectedDate', '$_currentSubject', '$dropdownType', '$_currentContent');
                      Navigator.pop(context);
                    }
                  },
                ),
              ]
          )
      ),

    );
  }
}