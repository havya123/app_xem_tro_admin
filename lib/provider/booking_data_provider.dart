import 'package:admin_app_xem_tro/repository/booking_reponsitory.dart';
import 'package:flutter/foundation.dart';

class BookingDataProvider extends ChangeNotifier {
  final BookingRepository _bookingRepository = BookingRepository();

  int _totalWaitingCount = 0;
  int _totalAcceptCount = 0;
  int _totalDeclineCount = 0;

  VoidCallback? onDataChanged;

  int get totalWaitingCount => _totalWaitingCount;
  int get totalAcceptCount => _totalAcceptCount;
  int get totalDeclineCount => _totalDeclineCount;

  Future<void> loadData() async {
    try {
      int newWaitingCount = await _bookingRepository.getTotalWaitingCount();
      int newAcceptCount = await _bookingRepository.getTotalAcceptCount();
      int newDeclineCount = await _bookingRepository.getTotalDeclineCount();

      // Check if the data has actually changed before updating
      if (_totalWaitingCount != newWaitingCount ||
          _totalAcceptCount != newAcceptCount ||
          _totalDeclineCount != newDeclineCount) {
        _totalWaitingCount = newWaitingCount;
        _totalAcceptCount = newAcceptCount;
        _totalDeclineCount = newDeclineCount;

        if (kDebugMode) {
          print('Total Waiting Count: $_totalWaitingCount');
          print('Total Accept Count: $_totalAcceptCount');
          print('Total Decline Count: $_totalDeclineCount');
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
