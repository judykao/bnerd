enum HomeworkStatus { active, done }

class Homework {
  int id;
  String title;
  DateTime created;
  DateTime updated;
  int status;

  Homework({this.id, this.title, this.created, this.updated, this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'created': created.toString(),
      'updated': updated.toString(),
      'status': status,
    };
  }

  Map<String, dynamic> toMapAutoID() {
    return {
      'title': title,
      'created': created.toString(),
      'updated': updated.toString(),
      'status': HomeworkStatus.active.index,
    };
  }


}

