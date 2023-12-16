// ignore_for_file: empty_catches

import 'package:admin_app_xem_tro/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<int> checkIfAdmin(String phoneNumber) async {
    Map<String, dynamic>? response = await FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .get()
        .then((value) => value.data());
    return response?["role"] ?? 0;
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

  Future<User> getUserByPhoneNumber(String phoneNumber) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('users').doc(phoneNumber).get();

    return User.fromMap(snapshot.data() ?? {});
  }

  Future<void> updateUserStatus(
      String userId, bool isBanned, int newRole) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .update({'isBanned': isBanned, 'role': newRole});
  }
}
