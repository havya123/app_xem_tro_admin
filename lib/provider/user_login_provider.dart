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
    try {
      bool isAdmin = await checkAdmin(phoneNumber, password);

      if (isAdmin) {
        String response = await UserRepo().logIn(phoneNumber);

        if (response.isEmpty) {
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
    } catch (e) {
      // Handle login error here
      print("Login error: $e");
      await _saveLoginStatus(false);
      return false;
    }
  }

  Future<bool> checkAdmin(String phoneNumber, String password) async {
    try {
      bool repositoryAdmin = await UserRepo().checkIfAdmin(phoneNumber);

      if (repositoryAdmin == false) {
        return false; // Not an admin
      } else {
        return true; // Is an admin
      }
    } catch (e) {
      // Handle checkAdmin error here
      print("CheckAdmin error: $e");
      return false; // Return a default value to indicate an error
    }
  }

  Future<void> _saveLoginStatus(bool status) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', status);
    } catch (e) {
      // Handle _saveLoginStatus error here
      print("SaveLoginStatus error: $e");
    }
  }

  Future<void> readLoginStatus() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      notifyListeners();
    } catch (e) {
      // Handle readLoginStatus error here
      print("ReadLoginStatus error: $e");
    }
  }

  Future<void> logout() async {
    try {
      await _saveLoginStatus(false);
      _isLoggedIn = false;
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const AdminLogin());
    } catch (e) {
      // Handle logout error here
      print("Logout error: $e");
    }
  }
}
