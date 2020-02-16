import 'package:bnerd/model/user.dart';
import 'package:bnerd/pages/wrapper.dart';
import 'package:bnerd/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value:Authservice().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}