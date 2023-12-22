// ignore_for_file: unnecessary_cast

import 'package:admin_app_xem_tro/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BarRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<User>> userRegistrationsStream() {
    DateTime startOfLastWeek = DateTime.now().subtract(const Duration(days: 7));
    DateTime endOfLastWeek = DateTime.now();

    return _firestore
        .collection('users')
        .where(
          'createAt',
          isGreaterThanOrEqualTo: startOfLastWeek,
          isLessThan: endOfLastWeek,
        )
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => User.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<User>> userRegistrationsYearStream() {
    DateTime startOfYear = DateTime.now().subtract(const Duration(days: 365));
    DateTime endOfYear = DateTime.now();

    return _firestore
        .collection('users')
        .where(
          'createAt',
          isGreaterThanOrEqualTo: startOfYear,
          isLessThan: endOfYear,
        )
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => User.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<List<User>> fetchUserRegistrations(
      DateTime start, DateTime end) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where(
          'createAt',
          isGreaterThanOrEqualTo: start,
          isLessThan: end,
        )
        .get();

    return querySnapshot.docs
        .map((doc) => User.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<User>> fetchUserRegistrationsYear(DateTime selectedYear) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where(
          'createAt',
          isGreaterThanOrEqualTo: selectedYear.subtract(const Duration(days: 365)),
          isLessThan: selectedYear,
        )
        .get();

    return querySnapshot.docs
        .map((doc) => User.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
