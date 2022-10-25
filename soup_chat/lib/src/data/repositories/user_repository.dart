import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soup_chat/src/domain/entities/user.dart';
import '../datasource/user_firebase.dart';

class UserRepository {

  static UserRepository? _instance;
  static final UserFireBase _userFireBase = UserFireBase.getInstance();


  static UserRepository? getInstance(){
    _instance ??= UserRepository._();
    return _instance;
  }

  UserRepository._();

  Future<SnapUser?> getUserById(String id) async{
    SnapUser? user = await _userFireBase.getUserById(id);
    return user;
  }

  Future<void> createUser(SnapUser user) async{
    String digestedString =  encryptEmail(user.email!);
    return _userFireBase.insertUser(user, digestedString.toString());
  }

  String encryptEmail(String email){
    var bytes1 = utf8.encode(email);         // data being hashed
    var digest1 = sha256.convert(bytes1);
    return digest1.toString();
  }

  Future<String?> uploadAvatar(XFile file, String? userId) async{
    String? downloadURL = await _userFireBase.uploadFile(file, userId);
    return downloadURL;
  }

  Future<String?> fetchAvatar() async {
    String? avatarURL = await _userFireBase.fetchImg();
    return avatarURL;
  }

  Future<SnapUser> getUserByEmail(String? email) async{
    QuerySnapshot<SnapUser> querySnapshot = await _userFireBase.searchUsersWithEmail(email!);
    return querySnapshot.docs.first.data();
  }

  String _getDate() {
    DateTime today = DateTime.now();
    return '${today.day}/${today.month}/${today.year}';
  }

  Future<List<QueryDocumentSnapshot<SnapUser>>> getAllUser() async{
    QuerySnapshot<SnapUser> triviaUsers = await _userFireBase.getAll();
    return triviaUsers.docs;
  }

  Future<void> updatePseudo(String email, String pseudo) async{
    String docId = encryptEmail(email);
    SnapUser? user = await _userFireBase.getUserById(docId);
    user?.setNickname = pseudo;
    _userFireBase.updateUser(user!, encryptEmail(email));
  }

}
