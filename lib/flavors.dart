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
        return 'flutter_template（开发）';
      case Flavor.env_test:
        return 'flutter_template（测试）';
      case Flavor.env_production:
        return 'flutter_template';
      default:
        return 'flutter_template';
    }
  }
}
