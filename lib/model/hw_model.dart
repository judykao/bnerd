enum HomeworkStatus { active, done }
//enum HomeworkType { hw, test, note }

class Homework {

  final String docuid;
  Homework({ this.docuid });
}


class HomeworkData {

  final String uid;
  final int id;
  final DateTime date;
  final String subject;
  final String type;
  final String content;
  final String title;
  final DateTime created;
  final DateTime updated;
  final int status;

  HomeworkData({this.uid, this.id, this.date, this.subject, this.type, this.content, this.title, this.created, this.updated, this.status});



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
