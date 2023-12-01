// ignore_for_file: unnecessary_cast

import 'package:admin_app_xem_tro/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BarRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<User>> fetchUserRegistrations(DateTime startDate) async {
    QuerySnapshot userSnapshot = await _firestore
        .collection('users')
        .where(
          'createAt',
          isGreaterThanOrEqualTo: startDate,
        )
        .get();

    return userSnapshot.docs
        .map((doc) => User.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}

