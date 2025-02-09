import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
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
      'sugars': sugars,
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

  //userdata from Snapshot
UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  var data = snapshot.data() as Map<String, dynamic>?; // On caste les données

  return UserData(
    uid: uid!, 
    name: data?['name'] ?? '',
    sugars: data?['sugars'] ?? '0',
    strength: data?['strength'] ?? 100,
  );
}

  //avoir stream de brews
  Stream<List<Brew>> get brews {
    return brewColection.snapshots().map(_brewListFromSnapshot);
  }

  //avoir user doc stream
  Stream<UserData> get userData {
    return brewColection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}