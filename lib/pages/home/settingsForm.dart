import 'package:flutter/material.dart';
import 'package:bnerd/services/database.dart';
import 'package:bnerd/shared/constants.dart';
import 'package:bnerd/model/user.dart';
import 'package:provider/provider.dart';
import 'package:bnerd/shared/load.dart';
import 'package:bnerd/model/bnerd.dart';


class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState> ();
  final List<String> numbers = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40',];

  //form values
  String _currentName;
  String _currentCla;
  String _currentNumber;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamProvider<List<Bnerd>>.value(
      value: DataBaseService().users,
      child: StreamBuilder<UserData>(
        stream: DataBaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){

            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your personal file.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.cla,
                    decoration: textInputDecoration.copyWith(hintText: 'Class'),
                    validator: (val) => val.isEmpty ? 'Please enter your class' : null,
                    onChanged: (val) => setState(() => _currentCla = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.number,
                    decoration: textInputDecoration.copyWith(hintText: 'NUmber'),
                    validator: (val) => val.isEmpty ? 'Please enter your number' : null,
                    onChanged: (val) => setState(() => _currentNumber = val),
                  ),
                  RaisedButton(
                    color: Colors.blueGrey[700],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        await DataBaseService(uid: user.uid).updateUserData(
                          _currentCla ?? userData.cla,
                          _currentNumber ?? userData.number,
                          _currentName ?? userData.name,
                        );
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
      )
    );
  }
}