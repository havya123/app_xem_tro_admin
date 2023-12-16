import 'package:admin_app_xem_tro/repository/booking_reponsitory.dart';
import 'package:flutter/foundation.dart';

class BookingDataProvider extends ChangeNotifier {
  final BookingRepository _bookingRepository = BookingRepository();

  int _totalBookedCount = 0;
  int _totalCancelCount = 0;

  VoidCallback? onDataChanged;

  int get totalBookedCount => _totalBookedCount;
  int get totalCancelCount => _totalCancelCount;

  Future<void> loadData() async {
    try {
      int newBookedCount = await _bookingRepository.getTotalBookedCount();
      int newCancelCount = await _bookingRepository.getTotalCancelCount();

      // Check if the data has actually changed before updating
      if (_totalBookedCount != newBookedCount || _totalCancelCount != newCancelCount) {
        _totalBookedCount = newBookedCount;
        _totalCancelCount = newCancelCount;

        if (kDebugMode) {
          print('Total Booking Count: $_totalBookedCount');
          print('Total Cancel Count: $_totalCancelCount');
        }

        onDataChanged?.call();
        notifyListeners();
      }
    } catch (error) {
      // Handle the error, such as logging or displaying an error message
      if (kDebugMode) {
        print("Error loading data: $error");
      }
    }
  }
}