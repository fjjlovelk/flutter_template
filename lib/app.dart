import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/router/app_pages.dart';
import 'package:flutter_template/utils/init_app_util.dart';
import 'package:get/get.dart';

import 'config/theme_config.dart';
import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      builder: (context, child) {
        ThemeConfig.init(context);
        return GetMaterialApp(
          title: F.title,
          builder: EasyLoading.init(
            builder: (BuildContext context, Widget? child) {
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  InitAppUtil.unFocus(context);
                },
                child: child,
              );
            },
          ),
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.cupertino,
          initialRoute: AppPages.initialRoute,
          getPages: AppPages.routes,
          unknownRoute: AppPages.unknownRoute,
          theme: ThemeConfig.themeData,
        );
      },
    );
  }
}
