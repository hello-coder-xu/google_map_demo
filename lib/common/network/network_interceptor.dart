import 'package:dio/dio.dart';

///网络请求拦截器
class NetworkInterceptor extends InterceptorsWrapper {
  String deviceId = '69a8eb91-2e5c-42f0-abd2-a3dc09b7bce2';

  /// 添加Header拦截器 <br/>
  addHeaderInterceptors(RequestOptions options) {
    options.headers["mobile_id"] = deviceId;
    options.headers["deviceid"] = deviceId;
    options.queryParameters["version"] = '4.3.2.224';
    options.headers["device"] = 'android';
  }

  /// 添加默认请求参数
  addParamsInterceptors(RequestOptions options) {
    options.queryParameters["mobile_id"] = deviceId;
    options.queryParameters["deviceid"] = deviceId;
    options.queryParameters["device_id"] = deviceId;
    options.queryParameters["version"] = '4.3.2.224';
    options.queryParameters["device"] = 'android';
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    addHeaderInterceptors(options);
    // addParamsInterceptors(options);
    return super.onRequest(options, handler);
  }
}
