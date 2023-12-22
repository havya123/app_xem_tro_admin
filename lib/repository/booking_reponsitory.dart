import 'package:cloud_firestore/cloud_firestore.dart';

class BookingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> getTotalWaitingCount() async {
    QuerySnapshot<Map<String, dynamic>> bookedSnapshot =
        await _firestore.collection('booking').where('status', isEqualTo: "waiting").get();

    return bookedSnapshot.docs.length;
  }

  Future<int> getTotalAcceptCount() async {
    QuerySnapshot<Map<String, dynamic>> cancelSnapshot =
        await _firestore.collection('booking').where('status', isEqualTo: "accept").get();

    return cancelSnapshot.docs.length;
  }

  Future<int> getTotalDeclineCount() async {
    QuerySnapshot<Map<String, dynamic>> cancelSnapshot =
        await _firestore.collection('booking').where('status', isEqualTo: "decline").get();

    return cancelSnapshot.docs.length;
  }
}