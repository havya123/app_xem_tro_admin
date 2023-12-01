import 'package:admin_app_xem_tro/models/house.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HouseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<House>> getHousesByStatusStream(String status) {
    return _firestore
        .collection('house')
        .where('status', isEqualTo: status)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => House.fromSnapshot(doc)).toList());
  }
}
