import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_map_demo/common/logger/logger_utils.dart';
import 'package:google_map_demo/common/routes/app_pages.dart';
import 'package:google_map_demo/common/services/global_service.dart';

///运行app
void main() async {
  await initServices();

  runApp(ScreenUtilInit(
    designSize: const Size(750, 1334),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: () => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      logWriterCallback: Logger.write,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    ),
  ));
}

/// 初始化服务
Future initServices() async {
  await Get.putAsync(() => GlobalService().init());
}
