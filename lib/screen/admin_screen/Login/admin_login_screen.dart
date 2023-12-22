// ignore_for_file: unused_element, use_build_context_synchronously, unused_local_variable

import 'package:admin_app_xem_tro/config/size_config.dart';
import 'package:admin_app_xem_tro/config/widget/check_box.dart';
import 'package:admin_app_xem_tro/config/widget/text_field.dart';
import 'package:admin_app_xem_tro/provider/user_login_provider.dart';
import 'package:admin_app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
// ignore: unnecessary_import
import 'package:provider/provider.dart';

class AdminLogin extends StatelessWidget {
  const AdminLogin({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var showpass = true.obs;
    void isHidden() {
      showpass.value = !showpass.value;
    }

    TextEditingController phoneController = TextEditingController();
    TextEditingController passController = TextEditingController();

    void loginCheck(String phoneNumber, String password) async {
      bool checking = await context
          .read<AdminUserLoginProvider>()
          .login(phoneNumber, password);
      bool checkAdmin = await context
          .read<AdminUserLoginProvider>()
          .checkAdmin(phoneNumber, password);
      if (checkAdmin) {
        if (checking) {
          Navigator.pushReplacementNamed(context, Routes.adminRoute);
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Center(child: Text('Đăng nhập thất bại')),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Tài khoản hoặc mật khẩu không chính xác'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Center(child: Text('Đăng nhập thất bại')),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Tài khoản không phải là ADMIN'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: padding(context, padding: 0.05),
            vertical: padding(context, padding: 0.02),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getHeight(context, height: 0.35),
                  width: getWidth(context, width: 0.8),
                  child: Image.asset(
                    "assets/images/splash_img/splash_icon.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Admin Login',
                  style: largeTextStyle(context, size: 0.04),
                ),
                SizedBox(
                  height: getHeight(context, height: 0.05),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        hint: 'Số điện thoại',
                        type: TextInputType.phone,
                        errorText: "Hãy nhập số điện thoại",
                        numberOfLetter: 10,
                        errorPass: "Yêu cầu nhập đủ 10 số điện thoại",
                        minLetter: 10,
                        controller: phoneController,
                      ),
                      SizedBox(
                        height: getHeight(context, height: 0.03),
                      ),
                      Obx(
                        () => TextFieldWidget(
                          hint: 'Mật khẩu',
                          isPass: showpass.value,
                          icon: IconButton(
                            onPressed: () {
                              isHidden();
                            },
                            icon: Obx(
                              () => Icon(
                                showpass.value
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          minLetter: 8,
                          errorText: "Hãy nhập mật khẩu",
                          errorPass: "Nhập đủ 8 ký tự",
                          controller: passController,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context, height: 0.01),
                ),
                Row(
                  children: [
                    const CheckboxExample(),
                    Expanded(
                      child: Text(
                        'Ghi nhớ tài khoản',
                        style: smallTextStyle(context, size: 0.025),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: getHeight(context, height: 0.01),
                ),
                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      loginCheck(phoneController.text, passController.text);
                      return;
                    } else {
                      return;
                    }
                  },
                  child: Ink(
                    child: Container(
                      height: getHeight(context, height: 0.09),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color.fromARGB(255, 141, 51, 186),
                      ),
                      child: Center(
                        child: Text(
                          'Xác nhận',
                          style: mediumTextStyle(context,
                              color: Colors.white, size: 0.03),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
