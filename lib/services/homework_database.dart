import 'package:cloud_firestore/cloud_firestore.dart';

class HomeworkDataBaseService {

  final String uid;

  HomeworkDataBaseService({ this.uid });

  //collection reference
  final CollectionReference homeworkCollection = Firestore.instance.collection(
      'homework');

  Future createHomeworkData(String date, String subject, String type,
      String content, String note) async {
    return await homeworkCollection.document().setData({
      'date': date,
      'subject': subject,
      'type': type,
      'content': content,
      'note': note,
    });
  }
}
  ///然後在要創建的按鈕的widget那邊加這行：
  ///await HomeworkDataBaseService().createHomeworkData('date', 'subject', 'type', 'content', 'note')