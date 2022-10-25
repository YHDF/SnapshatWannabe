import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebase{
  static AuthFirebase? _instance;
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  static getInstance(){
    _instance ??= AuthFirebase._();
    return _instance!;
  }

  AuthFirebase._();

  Future<UserCredential> signInWithCredentials({
    required String email, required String password}) async{
    UserCredential userCredential = await _fireBaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future<UserCredential?> signUp({required String email, required String password}) async{
    UserCredential userCredential = await _fireBaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  bool isSignIn(){
    return _fireBaseAuth.currentUser != null;
  }

  Future<void> signOut() async {
    await _fireBaseAuth.signOut();
  }

  String? getUser(){
    return (_fireBaseAuth.currentUser)?.email;
  }
}

