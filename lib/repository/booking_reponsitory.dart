import 'package:cloud_firestore/cloud_firestore.dart';

class BookingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> getTotalBookedCount() async {
    QuerySnapshot<Map<String, dynamic>> bookedSnapshot =
        await _firestore.collection('booking').where('status', isEqualTo: "booked").get();

    return bookedSnapshot.docs.length;
  }

  Future<int> getTotalCancelCount() async {
    QuerySnapshot<Map<String, dynamic>> cancelSnapshot =
        await _firestore.collection('booking').where('status', isEqualTo: "cancel").get();

    return cancelSnapshot.docs.length;
  }
}