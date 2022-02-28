import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map_demo/common/api/api.dart';
import 'package:google_map_demo/common/bean/area_bean.dart';
import 'package:google_map_demo/common/logger/logger_utils.dart';
import 'package:google_map_demo/common/network/http_request.dart';
import 'package:google_map_demo/page/map/logic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension AreaLogic on MapLogic {
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

        //绘制区域
        drawArea();
      },
    );
  }

  /// 绘制区域
  void drawArea() {
    if (state.polygons.isNotEmpty) {
      state.polygons.clear();
    } else {
      List<LatLng> temp = state.areaBean.data.geoBoundingBox
          .map((e) => LatLng(double.parse(e.lat), double.parse(e.lng)))
          .toList();

      const String polygonIdVal = 'polygon_id';
      const PolygonId polygonId = PolygonId(polygonIdVal);

      final Polygon polygon = Polygon(
        polygonId: polygonId,
        consumeTapEvents: true,
        strokeColor: const Color(0xffFF8000),
        strokeWidth: 4.w.toInt(),
        fillColor: const Color(0xffFF8000).withOpacity(0.1),
        points: temp,
        onTap: () {},
        geodesic: true,
      );
      state.polygons[polygonId] = polygon;
    }
    update();
  }
}
