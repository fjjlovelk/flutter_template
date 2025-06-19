import 'package:get/get.dart';

import '../pages/home_tabs/binding.dart';
import '../pages/home_tabs/view.dart';
import '../pages/login/binding.dart';
import '../pages/login/view.dart';
import '../pages/unknown/binding.dart';
import '../pages/unknown/view.dart';
import 'app_routes.dart';
import 'auth_middleware.dart';

class AppPages {
  /// 初始路由
  static const String initialRoute = AppRoutes.homeTabs;

  /// 未知路由
  static GetPage unknownRoute = GetPage(
    name: AppRoutes.unknown,
    page: () => const UnknownPage(),
    binding: UnknownBinding(),
  );

  /// 路由表
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.homeTabs,
      page: () => const HomeTabsPage(),
      binding: HomeTabsBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
