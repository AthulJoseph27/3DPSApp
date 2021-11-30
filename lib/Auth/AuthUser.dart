import 'package:firebase_auth/firebase_auth.dart';

class AuthUser{
  User user;
  String error;
  AuthUser(User user,String error){
    this.user = user;
    this.error = error;
  }
}