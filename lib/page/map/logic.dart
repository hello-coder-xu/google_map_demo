import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_demo/common/logger/logger_utils.dart';
import 'package:google_map_demo/page/map/area_logic.dart';
import 'package:google_map_demo/page/map/community_logic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'state.dart';

class MapLogic extends GetxController {
  final MapState state = MapState();

  @override
  void onInit() {
    state.kInitialPosition = CameraPosition(
      target: state.initLatLng,
      zoom: state.zoom,
    );
    super.onInit();
    loadAreaData();
    loadCommunityData();
  }

  /// popMenu 点击
  void popMenuClick(String result) {
    Logger.write(result);
    int index = state.popValue.indexOf(result);
    switch (index) {
      case 0: //台北
        break;
      case 1: //大头针
        drawMarker();
        break;
      case 2: //画区域
        drawArea();
        break;
      case 3: //画圆
        drawRound();
        break;
      case 4:
        loadAreaData();
        break;
      case 5:
        loadCommunityData();
        break;
    }
  }

  /// 获取地图控制器
  void onMapCreated(GoogleMapController controller) {
    state.controller = controller;
  }

  /// 地图点击
  void mapOnTap(LatLng result) {
    state.currentLatLng = result;
    Logger.write(result.toString());
    update();
  }

  /// 绘制圆
  void drawRound() {
    if (state.circles.isNotEmpty) {
      state.circles.clear();
    } else {
      const CircleId circleId = CircleId('circle_id');
      final Circle circle = Circle(
        circleId: circleId,
        consumeTapEvents: true,
        strokeColor: Colors.orange,
        fillColor: Colors.green.withOpacity(0.2),
        strokeWidth: 5,
        center: state.currentLatLng,
        radius: 100,
      );
      state.circles[circleId] = circle;
    }
    update();
  }
}
