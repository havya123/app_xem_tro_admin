import 'package:admin_app_xem_tro/firebase_options.dart';
import 'package:admin_app_xem_tro/provider/bar_provider.dart';
import 'package:admin_app_xem_tro/provider/combobox_value_provider.dart';
import 'package:admin_app_xem_tro/provider/house_provider.dart';
import 'package:admin_app_xem_tro/provider/user_login_provider.dart';
import 'package:admin_app_xem_tro/provider/user_provider.dart';
import 'package:admin_app_xem_tro/route/route_manager.dart';
import 'package:admin_app_xem_tro/route/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authProvider = AdminUserLoginProvider();
  await authProvider.readLoginStatus();

  runApp(AdminAppXemTro(authProvider: authProvider));
}

class AdminAppXemTro extends StatefulWidget {
  final AdminUserLoginProvider authProvider;

  const AdminAppXemTro({Key? key, required this.authProvider})
      : super(key: key);

  @override
  State<AdminAppXemTro> createState() => _AdminAppXemTroState();
}

class _AdminAppXemTroState extends State<AdminAppXemTro> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AdminUserProvider()),
        ChangeNotifierProvider.value(value: widget.authProvider),
        ChangeNotifierProvider(create: (context) => HouseProvider()),
        ChangeNotifierProvider(create: (context) => BarDataProvider()),
        ChangeNotifierProvider(create: (context) => ComboBoxValueProvider()),
      ],
      builder: (context, child) {
        return GetMaterialApp(
          builder: (context, child) {
            var isLandscape =
                MediaQuery.of(context).orientation == Orientation.landscape;
            SystemChrome.setPreferredOrientations([
              isLandscape
                  ? DeviceOrientation.landscapeLeft
                  : DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
            return child!;
          },
          debugShowCheckedModeBanner: false,
          initialRoute: widget.authProvider.isLoggedIn
              ? Routes.adminRoute
              : Routes.adminLoginRoute,
          getPages: RouteManager.routeManager,
          unknownRoute: RouteManager.notFound,
        );
      },
    );
  }
}
