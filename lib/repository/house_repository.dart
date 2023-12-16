import 'package:admin_app_xem_tro/models/house.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class HouseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<House>> getHousesByStatusStream(String status) {
    return _firestore
        .collection('house')
        .where('status', isEqualTo: status)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data();
        data['documentId'] = doc.id;
        return House.fromMap(data);
      }).toList();
    });
  }

  Future<List<House>> getHousesByStatus(String status) async {
    try {
      final snapshot = await _firestore
          .collection('house')
          .where('status', isEqualTo: status)
          .get();

      return snapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data();
        data['documentId'] = doc.id;
        return House.fromMap(data);
      }).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching houses by status: $e');
      }
      rethrow;
    }
  }
}

