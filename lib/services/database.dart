import 'package:brew_crew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({
    this.uid
  });

  // collection reference
  final CollectionReference brewColection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewColection.doc(uid).set({
      'sugras': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brew List from snashot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshots) {
    return snapshots.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;

      return Brew(
        name: data['name'] ?? '',
        strength: data['strength'] ?? 0,
        sugars: data['sugars'] ?? '0',
      );
    }).toList();
  }

  //avoir stream de brews
  Stream<List<Brew>> get brews {
    return brewColection.snapshots().map(_brewListFromSnapshot);
  }
}