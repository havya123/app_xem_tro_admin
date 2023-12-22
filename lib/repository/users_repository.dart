// ignore_for_file: empty_catches

import 'package:admin_app_xem_tro/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> logIn(String phoneNumber) async {
    Map<String, dynamic>? response = await FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .get()
        .then((value) => value.data());
    return response?["password"] ?? "";
  }

  Future<bool> checkIfAdmin(String phoneNumber) async {
    Map<String, dynamic>? response = await FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .get()
        .then((value) => value.data());
    return response?["isAdmin"] ?? false;
  }

  Future<String> checkIfPhoneNumberExists(String phoneNumber) async {
    Map<String, dynamic>? response = await FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .get()
        .then((value) => value.data());
    return response?["phoneNumber"] ?? "";
  }

  Future<bool> checkingNumberPhone(String phoneNumber) async {
    String response = await UserRepo().checkIfPhoneNumberExists(phoneNumber);
    if (phoneNumber == response) {
      return false;
    }
    return true;
  }

  Future<List<User>> getUsersByRole(int role) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('users')
        .where('role', isEqualTo: role)
        .get();

    return snapshot.docs.map((doc) => User.fromMap(doc.data())).toList();
  }

  Future<List<User>> getUsersisBan(bool isBanned) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection("users")
        .where("isBanned", isEqualTo: isBanned)
        .get();

    return snapshot.docs.map((doc) => User.fromMap(doc.data())).toList();
  }

  Future<void> updateUserStatus(String phoneNumbers, bool isBanned) async {
    if (phoneNumbers.isNotEmpty) {
      String userId = phoneNumbers.toString().split(".").last.substring(0,10);
      await _firestore
          .collection('users')
          .doc(userId)
          .update({'isBanned': isBanned});
    } else {
      if (kDebugMode) {
        print('User has no phone numbers.');
      }
    }
  }
}
