import 'dart:async';

import 'package:admin_app_xem_tro/models/house.dart';
import 'package:admin_app_xem_tro/repository/house_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class HouseProvider with ChangeNotifier {
  final HouseRepository _houseRepository = HouseRepository();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamSubscription<List<House>>? _allHousesSubscription;
  StreamSubscription<List<House>>? _housesWaitingSubscription;
  StreamSubscription<List<House>>? _housesAcceptSubscription;
  StreamSubscription<List<House>>? _housesDeclinesSubscription;

  List<House> allHouse = [];
  List<House> housesWaiting = [];
  List<House> housesAccept = [];
  List<House> housesDeclines = [];

  HouseProvider() {
    _init();
  }

  Future<void> acceptHouse(String houseId) async {
    try {
      await _firestore.collection('house').doc(houseId).update({
        'status': 'accept',
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error accepting house: $e');
      }
      rethrow;
    }
  }

  Future<void> rejectHouse(String houseId) async {
    try {
      await _firestore.collection('house').doc(houseId).update({
        'status': 'declines',
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error rejecting house: $e');
      }
      rethrow;
    }
  }

  void _init() {
    _housesWaitingSubscription =
        _houseRepository.getHousesByStatusStream('waiting').listen((houses) {
      try {
        housesWaiting = houses;
        if (kDebugMode) {
          print('Updated houses - Waiting: ${housesWaiting.length}');
        }
        notifyListeners();
      } catch (e) {
        // Handle error gracefully, log or show a user-friendly message
        if (kDebugMode) {
          print('Error updating houses - Waiting: $e');
        }
      }
    });

    _housesAcceptSubscription =
        _houseRepository.getHousesByStatusStream('accept').listen((houses) {
      try {
        housesAccept = houses;
        if (kDebugMode) {
          print('Updated houses - Approved: ${housesAccept.length}');
        }
        notifyListeners();
      } catch (e) {
        // Handle error gracefully, log or show a user-friendly message
        if (kDebugMode) {
          print('Error updating houses - Approved: $e');
        }
      }
    });

    _housesDeclinesSubscription =
        _houseRepository.getHousesByStatusStream('declines').listen((houses) {
      try {
        housesDeclines = houses;
        if (kDebugMode) {
          print('Updated houses - Rejected: ${housesDeclines.length}');
        }
        notifyListeners();
      } catch (e) {
        // Handle error gracefully, log or show a user-friendly message
        if (kDebugMode) {
          print('Error updating houses - Rejected: $e');
        }
      }
    });
  }

  @override
  void dispose() {
    _allHousesSubscription?.cancel();
    _housesWaitingSubscription?.cancel();
    _housesAcceptSubscription?.cancel();
    _housesDeclinesSubscription?.cancel();
    super.dispose();
  }
}
