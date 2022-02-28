import 'package:google_map_demo/common/api/api.dart';
import 'package:google_map_demo/common/bean/area_bean.dart';
import 'package:google_map_demo/common/bean/community_bean.dart';
import 'package:google_map_demo/common/logger/logger_utils.dart';
import 'package:google_map_demo/common/network/http_request.dart';
import 'package:google_map_demo/page/map/logic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension MapNetwrok on MapLogic {
  /// 加载地区范围
  void loadAreaData() {
    String url = Api.areaUrl;
    var param = {'area_id': '1', 'type': '1'};
    HttpRequest.getInstance().get(
      url,
      params: param,
      callBack: (data) {
        Logger.write(data.toString());
        state.areaBean = AreaBean.fromJson(data);

        List<LatLng> temp = state.areaBean.data.geoBoundingBox
            .map((e) => LatLng(double.parse(e.lat), double.parse(e.lng)))
            .toList();
        drawArea(temp);
      },
    );
  }

  /// 加载社区数据
  void loadCommunityData() {
    String url = Api.communityUrl;
    var param = {
      'post_type[]': '8',
      'points':
          '[[121.50104451924564,25.16689697307254],[121.50104451924564,24.898895105384458],[121.62979055196047,24.898895105384458],[121.62979055196047,25.16689697307254]]',
      'search_type': '3',
      'build_purpose': '',
      'device_id': '69a8eb91-2e5c-42f0-abd2-a3dc09b7bce2',
      'center': '25.032969370272014,121.56541753560306',
      'trans_date': '',
      'regionid': '1',
      'sectionid': '0',
      'location': '25.032969370272014,121.56541753560306',
      'zoom': '12.0',
      'price_unit': '0',
      'age': '0'
    };

    HttpRequest.getInstance().post(
      url,
      formData: param,
      callBack: (data) {
        Logger.write(data.toString());
        state.communityBean = CommunityBean.fromJson(data);
      },
    );
  }
}
