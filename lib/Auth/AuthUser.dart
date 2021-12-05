import 'package:firebase_auth/firebase_auth.dart';

class AuthUser{
  final User user;
  String role,error;
  AuthUser({this.user,this.role,this.error});
}