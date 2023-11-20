import 'package:admin_app_xem_tro/repository/users_repository.dart';
import 'package:flutter/material.dart';

class AdminUserProvider extends ChangeNotifier {

  Future<bool> checkingNumberPhone(String phoneNumber) async {
    String response = await UserRepo().checkIfPhoneNumberExists(phoneNumber);
    if (phoneNumber == response) {
      return false;
    }
    return true;
  }
}
