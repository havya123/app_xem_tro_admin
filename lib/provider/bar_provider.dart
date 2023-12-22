import 'package:admin_app_xem_tro/models/users.dart';
import 'package:admin_app_xem_tro/repository/bar_repository.dart';
import 'package:flutter/foundation.dart';

class BarDataProvider with ChangeNotifier {
  final BarRepository _barRepository = BarRepository();

  List<User> weeklyUserRegistrations = [];
  List<User> yearlyUserRegistrations = [];

  VoidCallback? onDataChanged;

  BarDataProvider() {
    // Listen for changes in the data
    _barRepository.userRegistrationsStream().listen((List<User> newData) {
      updateWeeklyUserRegistrations(newData);
    });

    _barRepository.userRegistrationsYearStream().listen((List<User> newData) {
      updateYearUserRegistrations(newData);
    });
  }

  Future<void> fetchUserRegistrations(
      DateTime selectedWeekStart, DateTime selectedWeekEnd) async {
    try {
      // Fetch new data for the selected week
      List<User> newWeeklyRegistrations = await _barRepository
          .fetchUserRegistrations(selectedWeekStart, selectedWeekEnd);

      // Update existing data with the new data
      updateWeeklyUserRegistrations(newWeeklyRegistrations);

      onDataChanged?.call();
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching user registrations week: $error');
      }
    }
  }

  void updateWeeklyUserRegistrations(List<User> newData) {
    weeklyUserRegistrations
      ..clear()
      ..addAll(newData);

    onDataChanged?.call();
    notifyListeners();
  }

  Future<void> fetchUserRegistrationsYear(DateTime selectedYear) async {
    try {
      List<User> newYearRegistrations =
          await _barRepository.fetchUserRegistrationsYear(selectedYear);

      updateYearUserRegistrations(newYearRegistrations);

      onDataChanged?.call();
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching user registrations year: $error');
      }
    }
  }

  void updateYearUserRegistrations(List<User> newData) {
    yearlyUserRegistrations
      ..clear()
      ..addAll(newData);

    onDataChanged?.call();
    notifyListeners();
  }
}
