// ignore_for_file: avoid_print

import 'package:admin_app_xem_tro/repository/users_repository.dart';
import 'package:flutter/material.dart';

class AdminUserLoginProvider extends ChangeNotifier {
  Future<bool> login(String phoneNumber, String password) async {
    bool repositoryAdmin = await UserRepo().checkIfAdmin(phoneNumber);
    String response = await UserRepo().logIn(phoneNumber);
    print(response);
    if (repositoryAdmin == true) {
      if (response == "") {
        return false;
      }
      if (password == response) {
        return true;
      }
    } else {
      return false;
    }

    return false;
  }

  Future<bool> checkAdmin(String phoneNumber, String password) async {
    bool repositoryAdmin = await UserRepo().checkIfAdmin(phoneNumber);
    if (repositoryAdmin == true) {
      return true;
    } else {
      return false;
    }
  }
}
