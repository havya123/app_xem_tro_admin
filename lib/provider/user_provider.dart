import 'package:admin_app_xem_tro/models/users.dart';
import 'package:admin_app_xem_tro/repository/users_repository.dart';
import 'package:flutter/foundation.dart';

class AdminUserProvider extends ChangeNotifier {
  final UserRepo _userRepository = UserRepo();

  Future<List<User>> loadUserListByRole(int role) async {
    try {
      List<User> loadedUsers = await _userRepository.getUsersByRole(role);
      return loadedUsers.where((user) => !user.isBanned).toList();
    } catch (e) {
      // Handle the error, such as logging or displaying an error message
      if (kDebugMode) {
        print('Error loading user list: $e');
      }
      rethrow;
    }
  }

  Future<List<User>> loadBlacklist() async {
    try {
      List<User> loadedUsers = await _userRepository.getUsersisBan(true);
      return loadedUsers.where((user) => user.isBanned).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading blacklist: $e');
      }
      rethrow;
    }
  }

  Future<void> toggleUserStatus(User user) async {
    try {
      bool newStatus = !user.isBanned;

      await _userRepository.updateUserStatus(user.phoneNumber, newStatus);
      if (kDebugMode) {
        print('User status toggled successfully: ${user.documentId}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error toggling user status: $e');
      }
      rethrow;
    }
  }
}
