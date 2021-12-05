import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:print_shop/Database/Database.dart';

import '../Globals.dart';
import 'AuthUser.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.authStateChanges();
  }

  Future<void> reloadUser()async{
    return await _auth.currentUser.reload();
  }

  // Register with Email
  Future<AuthUser> registerWithEmailAndPassword(String email,String password)async{
      try{
        UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        if(!result.user.emailVerified)
          result.user.sendEmailVerification();

        Database(uid:result.user.uid).insertUser(result.user.email, "Customer");
        return AuthUser(user:result.user,role:CUSTOMER,error:"");
      }catch(e){
        return AuthUser(user:null,role:"",error:e.toString());
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
      String role = CUSTOMER;
      bool alreadyRegistered = await Database(uid:result.user.uid).alreadyRegistered();
      if(alreadyRegistered)
        role = (await Database(uid: result.user.uid).getUser()).role;
      else
        Database(uid:result.user.uid).insertUser(result.user.email, role);
      return AuthUser(user:result.user,role:role,error:"");
    }catch(e){
      return AuthUser(user:null,role:"",error:e.toString());
    }
  }

  // Login with Email
  Future<AuthUser> loginWithEmailAndPassword(String email,String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      String role = (await Database(uid: result.user.uid).getUser()).role;
      return AuthUser(user:result.user,role:role,error:"");
    }catch(e){
      return AuthUser(user:null,role:"",error:e.toString());
    }
  }

  // Logout
  Future<void> logout()async {
    return await _auth.signOut();
  }
}