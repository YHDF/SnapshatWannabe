class User {
  int? _id;
  String? _email;
  String? _firstname;
  String? _lastname;
  String? _avatar;
  String? _nickname;
  String? _birthDate;

  User({int? id, String? firstname, String? lastname, String? email, String? nickname, String? avatar, String? birthDate,}) {
    _email = email;
    _id = id;
    _firstname = firstname;
    _lastname = lastname;
    _nickname = nickname;
    _birthDate = birthDate;
    _avatar = avatar;
  }

  int? get id => _id;

  set setId(int value) {
    _id = value;
  }

  String? get email => _email;

  set setEmail(String value) {
    _email = value;
  }

  String? get firstname => _firstname;

  set setFirstname(String value) {
    _firstname = value;
  }

  String? get lastname => _lastname;

  set setLastname(String value) {
    _lastname = value;
  }

  String? get avatar => _avatar;

  set setAvatar(String value) {
    _avatar = value;
  }

  String? get nickname => _nickname;

  set setNickname(String value) {
    _nickname = value;
  }

  String? get birthDate => _birthDate;

  set setBirthDate(String value) {
    _birthDate = value;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _nickname = json['nickname'];
    _avatar = json['avatar'];
    _birthDate = json['birthDate'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['birthDate'] = _birthDate;
    map['nickname'] = _nickname;
    map['lastname'] = _lastname;
    map['firstname'] = _firstname;
    map['email'] = _email;
    map['avatar'] = _avatar;
    return map;
  }
}