import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  bool? isAdmin;
  String password;
  String userID;
  String name;
  String phoneNumber;
  String dob;
  String email;
  String address;
  String? avatar;
  int role;
  DateTime createAt;
  bool isBanned;

  String get documentId => userID;

  User({
    required this.userID,
    required this.password,
    required this.name,
    required this.phoneNumber,
    required this.dob,
    required this.email,
    required this.address,
    this.avatar,
    this.isAdmin,
    required this.role,
    required this.createAt,
    required this.isBanned,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'name': name,
      'phoneNumber': phoneNumber,
      'dob': dob,
      'email': email,
      'address': address,
      'avatar': avatar,
      'role': role,
      'createAt': Timestamp.fromDate(createAt),
      "isBanned": isBanned,
      "isAdmin": isAdmin,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userID: map['userID'] ?? "",
      password: map['password'] ?? "",
      name: map['name'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      dob: map['dob'] ?? "",
      email: map['email'] ?? "",
      address: map['address'] ?? "",
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      role: map['role'] ?? 0,
      createAt: map['createAt'] != null
          ? (map['createAt'] as Timestamp).toDate()
          : DateTime.now(),
      isBanned: map['isBanned'] ?? false,
      isAdmin: map['isAdmin'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
