import 'package:flutter/material.dart';
import 'package:bnerd/widgets/shared.dart';
import 'package:bnerd/model/hw_model.dart' as Model;
import 'package:bnerd/utils/colors.dart';

const int NoTask = -1;
const int animationMilliseconds = 500;

class Homework extends StatefulWidget {
  final Function onTap;
  final Function onDeleteTask;
  final List<Model.HomeworkData> homeworks;

  Homework({@required this.homeworks, this.onTap, this.onDeleteTask});

  @override
  _HomeworkState createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {
  int taskPosition = NoTask;
  bool showCompletedTaskAnimation = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              if (widget.homeworks == null || widget.homeworks.length == 0)
                Container(
                  height: 10,
                ),
              if (widget.homeworks != null)
                for (int i = 0; i < widget.homeworks.length; ++i)
                  AnimatedOpacity(
                    curve: Curves.fastOutSlowIn,
                    opacity: taskPosition != i
                        ? 1.0
                        : showCompletedTaskAnimation ? 0 : 1,
                    duration: Duration(seconds: 1),
                    child: getTaskItem(
                      widget.homeworks[i].title,
                      index: i,
                      onTap: () {
                        setState(() {
                          taskPosition = i;
                          showCompletedTaskAnimation = true;
                        });
                        Future.delayed(
                          Duration(milliseconds: animationMilliseconds),
                        ).then((value) {
                          taskPosition = NoTask;
                          showCompletedTaskAnimation = false;
                          widget.onTap(pos: i);
                        });
                      },
                    ),
                  ),
            ],
          ),
        ),
        SharedWidget.getCardHeader(
            context: context,
            text: 'TODAY',
            customFontSize: 16,
            backgroundColorCode: TodosColor.kThirdColorCode,
        ),
      ],
    );
  }

  Widget getTaskItem(String text,
      {@required int index, @required Function onTap}) {
    return Container(
        child: Column(
          children: <Widget>[
            Dismissible(
              key: Key(text + '$index'),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                widget.onDeleteTask(todo: widget.homeworks[index]);
              },
              background: SharedWidget.getOnDismissDeleteBackground(),
              child: InkWell(
                onTap: onTap,
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        width: 7,
                        decoration: BoxDecoration(
                          color: TodosColor.sharedInstance.leadingTaskColor(index),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 10, top: 15, right: 20, bottom: 15),
                          child: Text(
                            text,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.title.copyWith(
                              color: Color(0xff373640),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0.5,
              child: Container(
                color: Colors.grey,
              ),
            ),
          ],
        ));
  }
}