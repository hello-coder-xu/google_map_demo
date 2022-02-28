import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_map_demo/common/network/http_request.dart';
import 'package:google_map_demo/common/network/http_request_setting.dart';
import 'package:google_map_demo/common/network/log_interceptor.dart';
import 'package:google_map_demo/common/network/network_interceptor.dart';

///全局服务
class GlobalService extends GetxService {
  static GlobalService get to => Get.find();

  Future<GlobalService> init() async {
    await GetStorage.init();
    initNetwork();
    return this;
  }

  ///初始化-网络请求
  static initNetwork() {
    HttpRequest.getInstance().init(HttpRequestSetting(
      connectTimeOut: 30,
      receiveTimeOut: 30,
      interceptors: [
        NetworkInterceptor(),
        LogPrintInterceptor(
          responseBody: true,
          showLog: true,
          requestHeader: true,
        ),
      ],
    ));
  }
}
