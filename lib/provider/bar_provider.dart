import 'dart:async';
import 'package:admin_app_xem_tro/models/users.dart';
import 'package:admin_app_xem_tro/repository/bar_repository.dart';
import 'package:flutter/foundation.dart';

class BarDataProvider with ChangeNotifier {
  final BarRepository _userRepository = BarRepository();

  List<User> weeklyUserRegistrations = [];
  List<User> monthlyUserRegistrations = [];

  VoidCallback? onDataChanged;

  Future<void> fetchUserRegistrations() async {
    try {
      DateTime now = DateTime.now();

      // Fetch weekly user registrations
      DateTime startOfLastWeek = now.subtract(Duration(days: now.weekday));
      weeklyUserRegistrations =
          await _userRepository.fetchUserRegistrations(startOfLastWeek);

      // Calculate the start of the previous month
      DateTime startOfLastMonth = DateTime(now.year, now.month - 1, 1);

      // Fetch monthly user registrations for the previous month
      monthlyUserRegistrations =
          await _userRepository.fetchUserRegistrations(startOfLastMonth);

      onDataChanged?.call();

      // if (kDebugMode) {
      //   print(
      //       'Weekly User Registrations Count: ${weeklyUserRegistrations.length}');
      //   print(
      //       'Monthly User Registrations Count: ${monthlyUserRegistrations.length}');
      // }
      notifyListeners();
    } catch (error) {
      // Handle the error, such as logging or displaying an error message
      if (kDebugMode) {
        print('Error fetching user registrations: $error');
      }
      // Optionally rethrow the error if it's critical and needs to be handled at a higher level
      // rethrow;
    }
  }

  void onNewUserRegistered() {
    // Fetch and update data for both weekly and monthly summaries
    fetchUserRegistrations().then((_) {
      notifyListeners();
    });
  }
}

