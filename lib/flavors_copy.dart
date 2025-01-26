enum Flavor {
  env_development,
  env_test,
  env_production,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.env_development:
        return 'flutter template（开发）';
      case Flavor.env_test:
        return 'flutter template（测试）';
      case Flavor.env_production:
        return 'flutter template';
      default:
        return 'flutter template';
    }
  }

  /// 接口请求路径
  static String get apiBaseUrl {
    switch (appFlavor) {
      case Flavor.env_development:
        return 'https://example.com';
      case Flavor.env_test:
        return 'https://example.com';
      case Flavor.env_production:
        return 'https://example.com';
      default:
        return 'https://example.com';
    }
  }
}
