import 'package:firebase_auth/firebase_auth.dart';
import '../../data/datasource/auth_firebase.dart';

class AuthRepository {

  static AuthRepository? _instance;
  static final AuthFirebase _authFirebase = AuthFirebase.getInstance();

  static AuthRepository? getInstance(){
    _instance ??= AuthRepository._();
    return _instance;
  }

  AuthRepository._();

  Future<User?> signIn({required email, required password}) async{
    UserCredential userCredential = await _authFirebase.signInWithCredentials(email: email, password: password);
    return userCredential.user;
  }
  Future<User?> signUp({required email,required password}) async{
    UserCredential? userCredential = await _authFirebase.signUp(email: email, password: password);
    return userCredential?.user;
  }

  bool isSignedIn() {
    return _authFirebase.isSignIn();
  }

  void signOut() {
    _authFirebase.signOut();
  }

  String? getUser(){
    return _authFirebase.getUser();
  }


}