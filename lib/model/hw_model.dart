enum HomeworkStatus { active, done }
enum Type { hw, test, note }

class Homework {

  final String uid;
  Homework({ this.uid });


}

class HomeworkData {

  final String uid;
  int id;
  DateTime date;
  String subject;
  int type;
  String content;
  String note;
  String title;
  DateTime created;
  DateTime updated;
  int status;

  HomeworkData({this.uid, this.id, this.date, this.subject, this.type, this.content, this.note, this.title, this.created, this.updated, this.status});



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

