import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class ThemeConfig {
  /// 默认颜色
  static Color primary = TDTheme.of(Get.context!).brandColor5;

  /// 信息色
  static Color info = TDTheme.of(Get.context!).grayColor5;

  /// 成功色
  static Color success = TDTheme.of(Get.context!).successColor5;

  /// 报错色
  static Color error = TDTheme.of(Get.context!).errorColor5;

  /// 警告色
  static Color warning = TDTheme.of(Get.context!).warningColor5;

  /// 背景色
  static Color n1 = const Color(0xffF7F8FA);

  /// 背景色
  static Color n2 = const Color(0xffF2F3F5);

  /// 边框、线色
  static Color n3 = const Color(0xffEDEDF0);

  /// 边框、线色
  static Color n4 = const Color(0xffDCDEE0);

  /// 文字色，指disable、提示文字等
  static Color n5 = const Color(0xffC8C9CC);

  /// 文字色，指辅助、说明文字
  static Color n6 = const Color(0xff969799);

  /// 文字色，指主文字2
  static Color n7 = const Color(0xff646566);

  /// 文字色，指主文字 1
  static Color n8 = const Color(0xff323233);

  /// 黑色
  static Color black = const Color(0xff000000);

  /// 白色
  static Color white = const Color(0xffffffff);

  /// mini padding
  static double miniPadding = 5.r;

  /// small padding
  static double smallPadding = 10.r;

  /// normal padding
  static double padding = 16.r;

  /// large padding
  static double largePadding = 20.r;

  /// mini radius
  static double miniRadius = 4.r;

  /// small radius
  static double smallRadius = 6.r;

  /// normal radius
  static double radius = 8.r;

  /// large radius
  static double largeRadius = 10.r;

  /// 取消按钮文字
  static const String cancelButtonText = '取消';

  /// 取消按钮文字颜色
  static Color cancelButtonColor = n7;

  /// 确认按钮文字
  static const String confirmButtonText = '确认';

  /// 确认按钮文字颜色
  static Color confirmButtonColor = primary;

  /// 弹框背景
  static final modalBackgroundColor = Colors.black.withValues(alpha: 0.5);

  /// 弹框高度
  static final smallModalHeight = Get.height * 2 / 5;

  /// 弹框高度
  static final modalHeight = Get.height * 3 / 5;

  /// 底部安全区域高度
  static final safeAreaBottom = MediaQuery.of(Get.context!).padding.bottom;

  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      primary: primary,
      secondary: info,
      surface: white,
      error: error,
      onPrimary: white,
      onSecondary: white,
      onSurface: n8,
      onError: white,
      brightness: Brightness.light,
    ),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    scaffoldBackgroundColor: n2,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: ThemeConfig.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: n2,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: CircleBorder(),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: ThemeConfig.white,
      contentPadding: EdgeInsets.symmetric(horizontal: padding),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: n5, fontSize: 14.sp),
    ),
    tabBarTheme: const TabBarThemeData(
      // 去除tab的bottom线条
      dividerHeight: 0,
      // 去除点击时的水波纹
      splashFactory: NoSplash.splashFactory,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ThemeConfig.largeRadius),
          topRight: Radius.circular(ThemeConfig.largeRadius),
        ),
      ),
    ),
  );
}
