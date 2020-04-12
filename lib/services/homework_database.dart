import 'package:bnerd/model/hw_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bnerd/model/homework.dart';

class HomeworkDataBaseService {

  final String uid;

  HomeworkDataBaseService({ this.uid });

  //collection reference
  final CollectionReference homeworkCollection = Firestore.instance.collection(
      'homework');
  final homeworkdata = Firestore.instance;

  Future createHomeworkData(String date, String subject, String type,
      String content) async {
    return await homeworkCollection.document().setData({
      'date': date,
      'subject': subject,
      'type': type,
      'content': content,
    });
  }

  List<HW> _HWListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return HW(
        date: doc.data['date'] ?? '',
        subject: doc.data['subject'] ?? '',
        type: doc.data['type'] ?? '',
        content: doc.data['content'] ?? '',
        note: doc.data['note'] ?? '',
      );
    }).toList();
  }

  Stream<List<HW>> get homeworks {
    return homeworkCollection.snapshots()
        .map(_HWListFromSnapshot);
  }

  HomeworkData _homeworkDataFromSnapshot(DocumentSnapshot snapshot) {
    return HomeworkData(
      uid: uid,
      date: snapshot.data['date'],
      subject: snapshot.data['subject'],
      type: snapshot.data['type'],
      content: snapshot.data['content'],
      note: snapshot.data['note'],
    );
  }

  Stream<HomeworkData> get homeworkData {
    return homeworkCollection.document(uid).snapshots()
        .map(_homeworkDataFromSnapshot);

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


  ///然後在要創建的按鈕的widget那邊加這行：
  ///await HomeworkDataBaseService().createHomeworkData('date', 'subject', 'type', 'content', 'note');