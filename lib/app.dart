import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/router/app_pages.dart';
import 'package:get/get.dart';

import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      builder: (context, child) {
        return GetMaterialApp(
          title: F.title,
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.cupertino,
          initialRoute: AppPages.initialRoute,
          getPages: AppPages.routes,
          unknownRoute: AppPages.unknownRoute,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              scrolledUnderElevation: 0,
              // backgroundColor: Color(0xffF1F1F1),
              backgroundColor: Colors.white,
            ),
            listTileTheme: ListTileThemeData(
              subtitleTextStyle: TextStyle(fontSize: 12.sp),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              shape: CircleBorder(),
            ),
            scaffoldBackgroundColor: const Color(0xffF1F1F1),
          ),
        );
      },
    );
  }
}
