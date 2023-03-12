import 'package:brew_crew/models/users.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../models/users.dart';

class AuthService {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  //create user obj based on firebvaseUser
   Users? _userFromFirebaseUser(User? user) {
     if (user!=null) {
       return Users(uid: user.uid);
     } else {
       return null;
     }
   }
  Stream<Users> get user {
    return _auth.authStateChanges()
        .map((User? user) =>  _userFromFirebaseUser(user!)!);
  }
  //sign in anon
   Future signInAnon() async{
     try{
       UserCredential result=await _auth.signInAnonymously();
       User? user=result.user;
       return user;
     }catch(e){
      print(e.toString());
      return null;
     }
   }
  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user=result.user!;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
   Future registerWithEmailAndPassword(String email,String password) async{
     try{
       UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
       User user=result.user!;
       //create a new document for the user with the0 uid
       await DatabaseService(uid:user.uid).updateUserData("0", "new crew Member", 100);
       return _userFromFirebaseUser(user);
     }catch(e){
       print(e.toString());
       return null;
     }
   }
   Future SignOut() async{
     try{
       return await _auth.signOut();
     }catch(e){
       print(e.toString());
       return null;
     }
   }
}