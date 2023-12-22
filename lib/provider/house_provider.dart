// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:admin_app_xem_tro/models/house.dart';
import 'package:admin_app_xem_tro/repository/house_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HouseProvider with ChangeNotifier {
  final HouseRepository _houseRepository = HouseRepository();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  StreamSubscription<List<House>>? _allHousesSubscription;
  StreamSubscription<List<House>>? _housesWaitingSubscription;
  StreamSubscription<List<House>>? _housesAcceptSubscription;
  StreamSubscription<List<House>>? _housesDeclinesSubscription;

  List<House> allHouse = [];
  List<House> housesWaiting = [];
  List<House> housesAccept = [];
  List<House> housesDeclines = [];

  BuildContext? _context;

  HouseProvider() {
    _init();
  }

  Future<void> refreshData() async {
    try {
      // Fetch waiting houses
      housesWaiting = await _houseRepository.getHousesByStatus('waiting');

      // Fetch accepted houses
      housesAccept = await _houseRepository.getHousesByStatus('accept');

      // Fetch declined houses
      housesDeclines = await _houseRepository.getHousesByStatus('declines');

      notifyListeners();
    } catch (e) {
      // Handle error gracefully, log, or show a user-friendly message
      if (kDebugMode) {
        print('Error refreshing data: $e');
      }
    }
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
      showSnackBar('Failed to accept house. Please try again.');
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
      showSnackBar('Failed to reject house. Please try again.');
      rethrow;
    }
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  void showSnackBar(String message) {
    if (_context != null) {
      final snackBar = SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(_context!).hideCurrentSnackBar();
          },
        ),
      );

      ScaffoldMessenger.of(_context!).showSnackBar(snackBar);
    } else {
      if (kDebugMode) {
        print("Context is not set. Unable to show SnackBar.");
      }
    }
  }

  void _init() {
    _housesWaitingSubscription =
        _houseRepository.getHousesByStatusStream('waiting').listen((houses) {
      try {
        housesWaiting = houses;
        if (kDebugMode) {
          print('Updated houses - Waiting: ${housesWaiting.length}');
          housesWaiting.forEach((house) {
            if (kDebugMode) {
              print(
                  'House ID: ${house.houseId}, Document ID: ${house.documentId}');
            }
          });
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
          housesWaiting.forEach((house) {
            if (kDebugMode) {
              print(
                  'House ID: ${house.houseId}, Document ID: ${house.documentId}');
            }
          });
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
          housesWaiting.forEach((house) {
            if (kDebugMode) {
              print(
                  'House ID: ${house.houseId}, Document ID: ${house.documentId}');
            }
          });
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
