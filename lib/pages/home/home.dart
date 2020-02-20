import 'package:bnerd/pages/home/settingsForm.dart';
import 'package:bnerd/services/database.dart';
import 'package:bnerd/services/homework_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:provider/provider.dart';
import 'package:bnerd/model/bnerd.dart';
import 'package:bnerd/widgets/TodayHW.dart';
import 'package:bnerd/model/hw_model.dart' as Model;

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  final homeworkdata = Firestore.instance;

  @override

  void initState() {
    // TODO: implement initState
    initUser();
    super.initState();
    getTodosAndDones();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }


  String mainProfilePicture = 'https://i.pinimg.com/564x/9f/4d/a8/9f4da811cfe7e06721313c4353fd58ed.jpg';
  String welcomeMsg;
  List<Model.Todo> todos;
  List<Model.Todo> dones;
  //List<Model.Homework> homeworks;



  void _showSettingsPanel() {
    showModalBottomSheet(context: context,builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        child: SettingsForm(),
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Bnerd>>.value(
      value: DataBaseService().users,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: Text('Today'),
          actions: <Widget>[
            Popup(
              getTodosAndDones: getTodosAndDones,
            ),
          ],
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
                Homework(
                  //homeworks: homeworks,
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
                accountName: Text("${user?.displayName}"),
                accountEmail: Text("${user?.email}"),
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
                onTap: () => _showSettingsPanel(),
              ),
              ListTile(
                title: Text('Log out'),
                trailing: Icon(Icons.person),
                onTap: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            _settingModalBottomSheet(context);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.grey[700],
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

  void createData() async {
    await homeworkdata.collection("homework")
        .document("1")
        .setData({
      'date': 'date',
      'subject': 'subject',
      'type': 'type',
      'content': 'content',
      'note': 'note',
    });
  }

//get資料
  void getData() {
    homeworkdata
        .collection("homework")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

//更新資料
  void updateData() {
    try {
      homeworkdata
          .collection('homework')
          .document('1')
          .updateData({'description': 'Head First Flutter'});
    } catch (e) {
      print(e.toString());
    }
  }

//刪除資料
  void deleteData() {
    try {
      homeworkdata
          .collection('homework')
          .document('1')
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }
}

Future<void> _settingModalBottomSheet(BuildContext context) async {
  await HomeworkDataBaseService().createHomeworkData('date', 'subject', 'type', 'content', 'note');
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: new Icon(Icons.date_range),
                  title: new Text('${DateTime.now()}'),
                  onTap: () => {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                      builder: (BuildContext context, Widget child) {
                        return Theme(
                          data: ThemeData.dark(),
                          child: child,
                        );
                      },
                    ),
                    /// 寫完讓widget 跑出來但還沒有取值
                  }
              ),
              new ListTile(
                leading: new Icon(Icons.merge_type),
                title: new Text('Type'),
                onTap: () => {
                  ///觸發下拉選單，可以設定類型
                },
              ),
            ],
          ),
        );
      }
  );
}

