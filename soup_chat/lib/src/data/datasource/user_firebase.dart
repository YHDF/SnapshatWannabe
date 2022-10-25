import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/user.dart';
import 'dart:io' as io;

class UserFireBase{
  static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  static UserFireBase? _instance;

  static late final CollectionReference<SnapUser> _userRef;

  UserFireBase._();

  static UserFireBase getInstance(){
    if(_instance == null){
      _userRef = _firebaseFirestore.collection('users').withConverter<SnapUser>(
        fromFirestore: (snapshot, _) => SnapUser.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
      _instance = UserFireBase._();
    }
    return _instance!;
  }

  Future<void> insertUser(SnapUser user, String docId) async{
    await _userRef.doc(docId).set(user);
    return;
  }

  Future<void> insertUserWithId(SnapUser user, String id) async{
    return _userRef.doc(id).set(user);
  }

  Future<void> updateUser(SnapUser user, String id) async{
    _userRef.doc(id).update(user.toJson());
  }

  Future<QuerySnapshot<SnapUser>> getAll() async{
    QuerySnapshot<SnapUser> test = await _userRef.get();
    test.docs.forEach((element) { });
    return _userRef.get();
  }

  Future<QuerySnapshot<SnapUser>> searchUsersWithpseudo(String nickname) async{
    return _userRef.where('nickname', isEqualTo: nickname).get();
  }

  Future<QuerySnapshot<SnapUser>> searchUsersWithEmail(String email) async{
    return _userRef.where('email', isEqualTo: email).get();
  }

  String? getUserUID() {
    return (_fireBaseAuth.currentUser)?.uid;
  }


  Future<SnapUser?> getUserById(String id) async{
    var document =  await _userRef.doc(id).get();
    return document.data();
  }

  Future<void> deleteUser(String id) async {
    return _userRef.doc(id).delete();
  }
  Future<String?> uploadFile(XFile file, String? userId) async {
    UploadTask uploadTask;
    final uid = _fireBaseAuth.currentUser?.uid;

    Reference ref = _firebaseStorage.ref().child('avatars').child('/$uid.jpg');

    final metadata = SettableMetadata(contentType: 'image/jpeg');

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }
    return Future.value(this.fetchImg());
  }

  Future<String?> fetchImg() async {
    var downloadURL = await _firebaseStorage
        .ref()
        .child("avatars").child(getUserUID()! + '.jpg')
        .getDownloadURL();

    return downloadURL.toString();
  }
}

