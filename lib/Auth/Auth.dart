import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'AuthUser.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.authStateChanges();
  }
  // Register with Email
  Future<AuthUser> registerWithEmailAndPassword(String email,String password)async{
      try{
        UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        return AuthUser(result.user,"");
      }catch(e){
        return AuthUser(null,e.toString());
      }
    }

  // Login with Google
  Future<AuthUser> loginWithGoogle()async{
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;

      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );

      UserCredential result = await _auth.signInWithCredential(credentials);
      return AuthUser(result.user, "");
    }catch(e){
      return AuthUser(null,e.toString());
    }
  }

  // Login with Email
  Future<AuthUser> loginWithEmailAndPassword(String email,String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return AuthUser(result.user,"");
    }catch(e){
      return AuthUser(null,e.toString());
    }
  }
  // Logout
}