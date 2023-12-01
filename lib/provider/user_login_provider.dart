// ignore_for_file: avoid_print, empty_catches, unrelated_type_equality_checks

import 'package:admin_app_xem_tro/repository/users_repository.dart';
import 'package:admin_app_xem_tro/screen/admin_screen/Login/admin_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminUserLoginProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<bool> login(String phoneNumber, String password) async {
    int repositoryAdmin = await UserRepo().checkIfAdmin(phoneNumber);
    String response = await UserRepo().logIn(phoneNumber);
    print(response);

    if (repositoryAdmin == 0) {
      if (response == "") {
        await _saveLoginStatus(false);
        return false;
      }
      if (password == response) {
        await _saveLoginStatus(true);
        _isLoggedIn = true;
        return true;
      }
    } else {
      await _saveLoginStatus(false);
      return false;
    }

    await _saveLoginStatus(false);
    return false;
  }

  Future<int> checkAdmin(String phoneNumber, String password) async {
    int repositoryAdmin = await UserRepo().checkIfAdmin(phoneNumber);
    if (repositoryAdmin == 0) {
      return 0;
    } else {
      return 1;
    }
  }

  Future<void> _saveLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
  }

  Future<void> readLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      await _saveLoginStatus(false);
      _isLoggedIn = false;
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const AdminLogin());
    } catch (e) {}
  }
}
