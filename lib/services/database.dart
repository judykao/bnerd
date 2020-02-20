import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bnerd/model/bnerd.dart';
import 'package:bnerd/model/user.dart';

class DataBaseService {

  final String uid;
  DataBaseService({ this.uid });

  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String cla, String number, String name) async {
    return await userCollection.document(uid).setData({
      'cla': cla,
      'number': number,
      'name': name,
    });

  }
  // bnerd list from snapshot
  List<Bnerd> _bnerdListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Bnerd(
        name: doc.data['name'] ?? '',
        cla: doc.data['cla'] ?? '',
        number: doc.data['number'] ?? '',
      );
    }).toList();
  }

  //get user stream
  Stream<List<Bnerd>> get users {
    return userCollection.snapshots()
        .map(_bnerdListFromSnapshot);
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      cla: snapshot.data['cla'],
      number: snapshot.data['number'],
    );
  }

  //get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);

  }
}