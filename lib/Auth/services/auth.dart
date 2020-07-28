import 'package:firebase_auth/firebase_auth.dart';
import 'package:News/Auth/models/user.dart';


class AuthService{
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebaseuser
  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null?User(uid:user.uid):null;
  }
  // auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
  }

  
}