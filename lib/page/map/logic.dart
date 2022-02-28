import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_demo/common/bean/city_bean.dart';
import 'package:google_map_demo/common/bean/community_bean.dart';
import 'package:google_map_demo/common/bean/villages_bean.dart';
import 'package:google_map_demo/common/logger/logger_utils.dart';
import 'package:google_map_demo/page/map/logic_area.dart';
import 'package:google_map_demo/page/map/logic_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'state.dart';

class MapLogic extends GetxController {
  final MapState state = MapState();

  @override
  void onInit() {
    super.onInit();
    state.kInitialPosition = CameraPosition(
      target: state.initLatLng,
      zoom: zoomValue,
    );
  }

  @override
  void onReady() {
    super.onReady();
    Logger.write('test onReady');

    // 此时map的controller还未创建好
  }

  /// 获取缩放比例值
  double get zoomValue {
    if (state.zoomType == 1) {
      return state.city;
    } else if (state.zoomType == 2) {
      return state.village;
    } else {
      return state.community;
    }
  }

  /// popMenu 点击
  void popMenuClick(String result) {
    Logger.write(result);
    int index = state.popValue.indexOf(result);
    switch (index) {
      case 0: //添加大头针
        drawMarker();
        break;
      case 1: //移除大头针
        clearMarker();
        break;
      case 2: //添加画区域
        drawArea();
        break;
      case 3: //移除画区域
        clearArea();
        break;
      case 4: // 加载区域数据
        loadAreaData();
        break;
      case 5: // 加载圆数据
        loadCommunityData();
        break;
      case 6: //显示底部视图
        state.displayBottomView = !state.displayBottomView;
        update();
        break;
    }
  }

  /// 获取地图控制器
  void onMapCreated(GoogleMapController controller) {
    state.controller = controller;
    Logger.write('test onMapCreated 完成');

    // 此方法只执行一次
    loadAreaData();
    loadCommunityData();
  }

  /// 地图点击
  void mapOnTap(LatLng result) {
    state.currentLatLng = result;
    Logger.write(result.toString());
    update();
  }

  /// 城市-大头针点击
  void markerCityClick(CityItem bean, LatLng position) {
    state.zoomType = 2;
    state.regionId = '${bean.regionId}';
    state.sectionId = '${bean.sectionId}';

    state.areaId = '${bean.sectionId}';
    state.areaType = 2;

    //移动并放大
    state.controller
        ?.animateCamera(CameraUpdate.newLatLngZoom(position, zoomValue));

    //加载区域数据
    loadAreaData();

    //加载社区数据
    loadCommunityData();
  }

  /// 乡村-大头针点击
  void markerVillageClick(VillageItem bean, LatLng position) {
    state.zoomType = 3;

    state.areaId = '${bean.shopId}';
    state.areaType = 3;

    //移动并放大
    state.controller
        ?.animateCamera(CameraUpdate.newLatLngZoom(position, zoomValue));

    //加载区域数据
    loadAreaData();

    //加载社区数据
    loadCommunityData();
  }

  /// 社区-大头针点击
  void markerCommunityClick(CommunityItem bean, LatLng position) {

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
