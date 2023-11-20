import 'package:admin_app_xem_tro/screen/admin_screen/admin_account_screen.dart';
import 'package:admin_app_xem_tro/screen/admin_screen/admin_approve_screen.dart';
import 'package:admin_app_xem_tro/screen/admin_screen/admin_booking_screen.dart';
import 'package:admin_app_xem_tro/screen/admin_screen/admin_login_screen.dart';
import 'package:admin_app_xem_tro/screen/admin_screen/admin_screen.dart';
import 'package:admin_app_xem_tro/screen/error_screen/error_screen.dart';
import 'package:admin_app_xem_tro/screen/splash_admin/splash_admin_screen.dart';
import 'package:get/get.dart';

class RouteManager {
  static List<GetPage> routeManager = [
    GetPage(
      name: "/notFoundRoute",
      page: () => const ErrorScreen(),
    ),
    GetPage(
      name: "/splashAdminRoute",
      page: () => const SplashScreenAdmin(),
    ),
    GetPage(
      name: "/adminLoginRoute",
      page: () => const AdminLogin(),
    ),
    GetPage(
      name: "/adminRoute",
      page: () => const AdminScreen(),
    ),
    GetPage(
      name: "/adminAccountRoute",
      page: () => const AdminAccountScreen(),
    ),
    GetPage(
      name: "/adminBookingRoute",
      page: () => const AdminBookingScreen(),
    ),
    GetPage(
      name: "/adminApproveRoute",
      page: () => const AdminApproveScreen(),
    ),
  ];
  static GetPage notFound = GetPage(
    name: "/notFoundRoute",
    page: () => const ErrorScreen(),
  );
}
