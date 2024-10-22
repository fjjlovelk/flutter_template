enum Flavor {
  env_development,
  env_test,
  env_production,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  /// app标题
  static String get title {
    switch (appFlavor) {
      case Flavor.env_development:
        return 'flutter_template（开发）';
      case Flavor.env_test:
        return 'flutter_template（测试）';
      case Flavor.env_production:
        return 'flutter_template';
      default:
        return 'flutter_template';
    }
  }

  /// 接口请求路径
  static String get apiBaseUrl {
    switch (appFlavor) {
      case Flavor.env_development:
        return 'http://env_development.com';
      case Flavor.env_test:
        return 'http://env_test.com';
      case Flavor.env_production:
        return 'http://env_production.com';
      default:
        return 'http://env_development.com';
    }
  }
}
