import 'package:admin_app_xem_tro/firebase_options.dart';
import 'package:admin_app_xem_tro/provider/user_login_provider.dart';
import 'package:admin_app_xem_tro/provider/user_provider.dart';
import 'package:admin_app_xem_tro/route/route_manager.dart';
import 'package:admin_app_xem_tro/route/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AdminAppXemTro());
}

class AdminAppXemTro extends StatefulWidget {
  const AdminAppXemTro({super.key});

  @override
  State<AdminAppXemTro> createState() => _AdminAppXemTroState();
}

class _AdminAppXemTroState extends State<AdminAppXemTro> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AdminUserProvider()),
        ChangeNotifierProvider(create: (context) => AdminUserLoginProvider()),
          ],
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.adminLoginRoute,
            getPages: RouteManager.routeManager,
            unknownRoute: RouteManager.notFound,
          );
        });
  }
}
