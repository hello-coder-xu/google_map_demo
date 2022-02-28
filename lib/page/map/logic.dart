import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_map_demo/common/logger/logger_utils.dart';
import 'package:google_map_demo/page/map/network_logic.dart';
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
    loadAreaData();
    super.onInit();
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
        // drawArea();
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

  /// 增加大头针
  void drawMarker() async {
    if (state.markers.isNotEmpty) {
      state.markers.clear();
    } else {
      // 系统大头针
      // const MarkerId markerId = MarkerId('marker_id');
      // final Marker marker = Marker(
      //   markerId: markerId,
      //   position: LatLng(state.initLatLng.latitude, state.initLatLng.longitude),
      //   infoWindow: const InfoWindow(title: 'marker_id', snippet: '*'),
      //   onTap: () => {},
      //   onDragEnd: (LatLng position) => {},
      //   onDrag: (LatLng position) => {},
      // );
      // state.markers[markerId] = marker;

      //自定义大头针
      BitmapDescriptor icon = await getIcon('松山区\n82.7万', Colors.red);
      const MarkerId markerId = MarkerId('marker_id');
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(state.initLatLng.latitude, state.initLatLng.longitude),
        infoWindow: const InfoWindow(title: 'marker_id', snippet: '*'),
        icon: icon,
      );
      state.markers[markerId] = marker;
    }
    update();
  }

  /// 绘制区域
  void drawArea(List<LatLng> points) {
    if (state.polygons.isNotEmpty) {
      state.polygons.clear();
    } else {
      const String polygonIdVal = 'polygon_id';
      const PolygonId polygonId = PolygonId(polygonIdVal);

      final Polygon polygon = Polygon(
        polygonId: polygonId,
        consumeTapEvents: true,
        strokeColor: const Color(0xffFF8000),
        strokeWidth: 4.w.toInt(),
        fillColor: const Color(0xffFF8000).withOpacity(0.1),
        points: points,
        onTap: () {},
        geodesic: true,
      );
      state.polygons[polygonId] = polygon;
    }
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

  Future<BitmapDescriptor> getIcon(String title, Color color) async {
    double width = 0.38.sw * 2;
    double height = 0.085.sw * 2;
    double sideSize = 0.02.sw * 2;

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = color;
    final Radius radius = Radius.circular(height / 2);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        paint);
    var path = Path();
    path.moveTo(width / 2, height + sideSize);
    path.lineTo(width / 2 - sideSize, height - 3);
    path.lineTo(width / 2 + sideSize, height - 3);
    path.close();
    canvas.drawPath(path, paint);

    TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
      ellipsis: '...',
    );
    painter.text = TextSpan(
      text: title,
      style: TextStyle(
        fontSize: 64.sp,
        color: Colors.white,
      ),
    );

    painter.layout();
    painter.paint(
        canvas,
        Offset((width * 0.5) - painter.width * 0.5,
            (height * .5) - painter.height * 0.5));
    final img = await pictureRecorder
        .endRecording()
        .toImage(width.toInt(), height.toInt() + sideSize.toInt());
    ByteData? data = await img.toByteData(format: ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}
