import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../store/user_store.dart';
import 'app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.hasToken) {
      return null;
    }
    return const RouteSettings(name: AppRoutes.login);
  }
}
