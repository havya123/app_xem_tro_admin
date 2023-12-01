import 'package:admin_app_xem_tro/models/users.dart';
import 'package:admin_app_xem_tro/repository/users_repository.dart';
import 'package:flutter/material.dart';

class AdminUserProvider extends ChangeNotifier {
  final UserRepo _userRepository = UserRepo();

  Future<List<User>> loadUserListByRole(int role) async {
    List<User> loadedUsers = await _userRepository.getUsersByRole(role);
    return loadedUsers.where((user) => !user.isBanned).toList();
  }

  Future<List<User>> loadBlacklist() async {
    return await _userRepository.getUsersByRole(3);
  }

  Future<void> toggleUserStatus(User user) async {
    bool newStatus = !user.isBanned;
    await _userRepository.updateUserStatus(user.id, newStatus);
  }
}
