import 'package:bnerd/pages//To-Do.dart';
import 'package:bnerd/pages/home.dart';
import 'package:bnerd/pages/loading.dart';
import 'package:flutter/material.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/Todo': (context) => Toodo(),
  },
));