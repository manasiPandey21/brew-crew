import 'package:brew_crew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});
  DatabaseService.withoutUID() : uid = "";

  final CollectionReference brewCollection = FirebaseFirestore.instance
      .collection("brews");

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      "sugars": sugars,
      "name": name,
      "strength": strength,
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(
          name: (doc.data() as dynamic)["name"]??"",
          sugars: (doc.data() as dynamic)["sugars"]??"0",
          strength:  (doc.data() as dynamic)["strength"]??0
      );
    }).toList();
  }
  Stream <  List<Brew>> get brews{
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
}



