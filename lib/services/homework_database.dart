import 'package:bnerd/model/hw_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bnerd/model/homework.dart';
import 'package:bnerd/widgets/addHW.dart';

// final List<String> id = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25'];
// int i = 0;
class HomeworkDataBaseService {

  final String docuid;

  HomeworkDataBaseService({this.docuid });
  
  
  //collection reference
  final CollectionReference homeworkCollection = Firestore.instance.collection(
      'homework');
  final homeworkdata = Firestore.instance;
  Future createHomeworkData(String date, String subject, String type, String content) async {
    return await homeworkCollection.document(id[i]).setData(
      {
      'date': date,
      'subject': subject,
      'type': type,
      'content': content,
      },
    );
  }
  
  List<HW> _HWListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return HW(
        date: doc.data['date'] ?? '',
        subject: doc.data['subject'] ?? '',
        type: doc.data['type'] ?? '',
        content: doc.data['content'] ?? '',
      );
    }).toList();
  }

  Stream<List<HW>> get homeworks {
    return homeworkCollection.snapshots()
        .map(_HWListFromSnapshot);
  }

  HomeworkData _homeworkDataFromSnapshot(DocumentSnapshot snapshot) {
    return HomeworkData(
      uid: docuid,
      date: snapshot.data['date'],
      subject: snapshot.data['subject'],
      type: snapshot.data['type'],
      content: snapshot.data['content'],
    );
  }

  Stream<HomeworkData> get homeworkData {
    return homeworkCollection.document(docuid).snapshots()
        .map(_homeworkDataFromSnapshot);

  }
}