import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_demo/common/logger/logger_utils.dart';
import 'package:google_map_demo/page/map/logic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  final logic = Get.put(MapLogic());
  final state = Get.find<MapLogic>().state;

  MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapLogic>(
      init: logic,
      initState: (_) {},
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('map'),
            centerTitle: true,
            actions: [
              PopupMenuButton<String>(
                onSelected: logic.popMenuClick,
                itemBuilder: (context) => state.popValue
                    .map((element) => PopupMenuItem<String>(
                          value: element,
                          child: Text(element),
                        ))
                    .toList(),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(child: mapView),
              bottomView,
            ],
          ),
        );
      },
    );
  }

  /// 地图+定位
  Widget get mapView => GoogleMap(
        initialCameraPosition: state.kInitialPosition,
        //获取controller
        onMapCreated: logic.onMapCreated,
        //是否显示指南针(旋转时才出现)
        compassEnabled: true,
        //-----不清楚-------
        mapToolbarEnabled: true,
        //不清楚- 貌似限制纬度范围可以滑动
        // cameraTargetBounds: CameraTargetBounds(LatLngBounds(
        //   southwest: const LatLng(25.030516004085843, 121.56562339514493),
        //   northeast: const LatLng(25.038939448328417, 121.56360704451801),
        // )),
        //地图显示模式
        mapType: MapType.normal,
        // 大小缩放范围
        // minMaxZoomPreference: const MinMaxZoomPreference(8, 16.0),
        //地图是否可以旋转
        rotateGesturesEnabled: true,
        //是否可以滚动
        scrollGesturesEnabled: true,
        //不显示加减 by android
        zoomControlsEnabled: true,
        //是否支持手势缩放
        zoomGesturesEnabled: true,
        // 地图是否为精简模式(不可指定位置与缩放拖地地图)  by android
        liteModeEnabled: false,
        //-----不清楚-------
        tiltGesturesEnabled: false,
        // 定为是否可用
        myLocationEnabled: true,
        // 是否google map 应用按钮
        myLocationButtonEnabled: true,
        //-----不清楚-------
        layoutDirection: TextDirection.rtl,
        // 设置定位按钮|缩放按钮在地图上的内间距
        padding: const EdgeInsets.only(top: 600),
        //-----不清楚-------
        indoorViewEnabled: true,
        //是否显示交通
        trafficEnabled: false,
        // 是否显示3d视图
        buildingsEnabled: true,
        //大头针
        markers: Set<Marker>.of(state.markers.values),
        //区域
        polygons: Set<Polygon>.of(state.polygons.values),
        //线路
        polylines: Set<Polyline>.of(state.polyLines.values),
        //圆
        circles: Set<Circle>.of(state.circles.values),
        //地图移动开始-执行方法
        onCameraMoveStarted: () {
          Logger.write('test onCameraMoveStarted');
        },
        //在地图上绘制一个层(可自定义)
        tileOverlays: Set<TileOverlay>.of(state.tileOverlays.values),
        // 地图移动+缩放执行的方法
        onCameraMove: (CameraPosition position) {
          Logger.write('test position=$position');
        },
        //地图移动结束-执行方法
        onCameraIdle: () {
          Logger.write('test onCameraIdle');
        },
        //点击-执行方法
        onTap: logic.mapOnTap,
        //长按-执行方法
        onLongPress: (LatLng? latLng) {
          Logger.write('test onLongPress latLng=$latLng');
        },
      );

  /// 底部显示视图
  Widget get bottomView => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text('latitude:${state.currentLatLng.latitude}'),
              height: 30,
              alignment: Alignment.centerLeft,
            ),
            Container(
              child: Text('longitude:${state.currentLatLng.longitude}'),
              height: 30,
              alignment: Alignment.centerLeft,
            ),
          ],
        ),
      );
}
