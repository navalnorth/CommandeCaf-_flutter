import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Créer un objet de user avec firebaseUser
  UserObject? _userFromFirebase(User? user) {
    return user != null ? UserObject(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserObject?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  // se connecter en anonyme
  Future signInAnom() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // se connecter avec le mail et le mdp
  Future signInWithEmalAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //s'inscrire avec le mail et le mdp
  Future registerWithEmalAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //reer un noiveau document pour l'user avec uid
      await DatabaseService(uid: user!.uid).updateUserData('0', "new crew member", 100);

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //se deonnecter
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  
}