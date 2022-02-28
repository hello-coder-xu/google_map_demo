import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:google_map_demo/page/map/view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.map;

  static final routes = [
    GetPage(
      name: Paths.map,
      preventDuplicates: true, //防止重复
      page: () => MapPage(),
    ),
  ];
}
