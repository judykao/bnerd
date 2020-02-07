import 'package:flutter/material.dart';
import 'package:bnerd/widgets/Todo.dart';
import 'package:bnerd/widgets/task_input.dart';
import 'package:bnerd/pages/Archive.dart';
import 'package:bnerd/utils/utils.dart';
import 'package:bnerd/model/model.dart' as Model;
import 'package:bnerd/widgets/done.dart';
import 'package:bnerd/model/db_wrapper.dart';
import 'package:bnerd/widgets/popup.dart';
import 'package:bnerd/pages/To-Do.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String mainProfilePicture = 'https://i.pinimg.com/564x/9f/4d/a8/9f4da811cfe7e06721313c4353fd58ed.jpg';
  String welcomeMsg;
  List<Model.Todo> todos;
  List<Model.Todo> dones;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodosAndDones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Today'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  //margin: EdgeInsets.only(top: 35),
                  child: Popup(
                    getTodosAndDones: getTodosAndDones,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        child: GestureDetector(
          onTap: () {
            Utils.hideKeyboard(context);
          },
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: TaskInput(
                          onSubmitted: addTaskInTodo,
                        ), // Add Todos
                      ),
                    ],
                  ),
                ],
              ),
              Todo(
                todos: todos,
                onTap: markTodoAsDone,
                onDeleteTask: deleteTask,
              ),
              Done(
                dones: dones,
                onTap: markDoneAsTodo,
                onDeleteTask: deleteTask,
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Judy Kao'),
              accountEmail: Text('imjudykao@gmail.com'),
              currentAccountPicture: GestureDetector(
                onTap: () => print('This is the current user.'),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(mainProfilePicture),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage('https://i.pinimg.com/564x/74/f1/59/74f159a8aebaa53a5fb139397ec3ff61.jpg'),
                ),
              ),
            ),
            ListTile(
              title: Text('Todo'),
              trailing: Icon(Icons.lightbulb_outline),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Toodo()));
              },
            ),
            ListTile(
              title: Text('Archive'),
              trailing: Icon(Icons.archive),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Archive()));
              },
            ),
            Divider(),
            ListTile(
              title: Text('Settings'),
              trailing: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }


  void getTodosAndDones() async {
    final _todos = await DBWrapper.sharedInstance.getTodos();
    final _dones = await DBWrapper.sharedInstance.getDones();

    setState(() {
      todos = _todos;
      dones = _dones;
    });
  }

  void addTaskInTodo({@required TextEditingController controller}) {
    final inputText = controller.text.trim();

    if (inputText.length > 0) {
      // Add todos
      Model.Todo todo = Model.Todo(
        title: inputText,
        created: DateTime.now(),
        updated: DateTime.now(),
        status: Model.TodoStatus.active.index,
      );

      DBWrapper.sharedInstance.addTodo(todo);
      getTodosAndDones();
    } else {
      Utils.hideKeyboard(context);
    }

    controller.text = '';
  }

  void markTodoAsDone({@required int pos}) {
    DBWrapper.sharedInstance.markTodoAsDone(todos[pos]);
    getTodosAndDones();
  }

  void markDoneAsTodo({@required int pos}) {
    DBWrapper.sharedInstance.markDoneAsTodo(dones[pos]);
    getTodosAndDones();
  }

  void deleteTask({@required Model.Todo todo}) {
    DBWrapper.sharedInstance.deleteTodo(todo);
    getTodosAndDones();
  }
}
