import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map_demo/common/api/api.dart';
import 'package:google_map_demo/common/bean/city_bean.dart';
import 'package:google_map_demo/common/bean/community_bean.dart';
import 'package:google_map_demo/common/bean/villages_bean.dart';
import 'package:google_map_demo/common/logger/logger_utils.dart';
import 'package:google_map_demo/common/network/http_request.dart';
import 'package:google_map_demo/page/map/logic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension MarkerLogic on MapLogic {
  /// 加载社区数据
  void loadCommunityData() async {
    LatLngBounds? latLngBounds = await state.controller?.getVisibleRegion();

    Logger.write('test loadCommunityData：${latLngBounds?.toJson()}');
    if (latLngBounds == null) return;
    // 西南 -- 左下角
    LatLng leftDown = latLngBounds.southwest;
    String leftDownValue = '[${leftDown.longitude},${leftDown.latitude}]';
    // 东北 -- 右上角
    LatLng rightUp = latLngBounds.northeast;
    String rightUpValue = '[${rightUp.longitude},${rightUp.latitude}]';

    // 西北 -- 左上角
    LatLng leftUp = LatLng(leftDown.latitude, rightUp.longitude);
    String leftUpValue = '[${leftUp.longitude},${leftUp.latitude}]';

    // 东南 -- 右下角
    LatLng rightDown = LatLng(rightUp.latitude, leftDown.longitude);
    String rightDownValue = '[${rightDown.longitude},${rightDown.latitude}]';

    String points =
        '[$leftUpValue,$rightUpValue,$leftDownValue,$rightDownValue]';

    int searchType = 3;
    if (state.zoomType == 1) {
      searchType = 3;
    } else if (state.zoomType == 2) {
      searchType = 5;
    } else if (state.zoomType == 3) {
      searchType = 1;
    }

    String url = Api.communityUrl;
    var param = {
      'points': points,
      'search_type': searchType,
      // 'regionid': state.regionId,
      'regionid': '0',
      'sectionid': state.sectionId,
      'zoom': zoomValue,
    };

    HttpRequest.getInstance().post(
      url,
      formData: param,
      callBack: (data) {
        Logger.write(data.toString());

        if (state.zoomType == 1) {
          state.cityBean = CityBean.fromJson(data);
        } else if (state.zoomType == 2) {
          state.villageBean = VillageBean.fromJson(data);
        } else if (state.zoomType == 3) {
          state.communityBean = CommunityBean.fromJson(data);
        }

        // 绘制圆
        drawMarker();
      },
    );
  }

  /// 增加大头针
  void drawMarker() async {
    // 清除之前的
    clearMarker();

    //自定义大头针
    if (state.zoomType == 1) {
      //城市
      List<CityItem>? list = state.cityBean?.data.items;

      if (list == null) return;
      for (var bean in list) {
        String title = bean.sectionName;
        String value = '${bean.priceUnit.price}${bean.priceUnit.unit}';
        BitmapDescriptor icon = await getRoundIcon('$title\n$value');
        MarkerId markerId = MarkerId('marker_${bean.sectionId}');
        LatLng position =
            LatLng(double.parse(bean.lat), double.parse(bean.lng));
        final Marker marker = Marker(
          markerId: markerId,
          position: position,
          icon: icon,
          onTap: () => markerCityClick(bean, position),
        );
        state.markers[markerId] = marker;
      }
    } else if (state.zoomType == 2) {
      //乡村
      List<VillageItem>? list = state.villageBean?.data.items;
      if (list == null) return;
      for (var bean in list) {
        String title = bean.shopName;
        BitmapDescriptor icon = await getRoundIcon(title);
        MarkerId markerId = MarkerId('marker_${bean.shopId}');
        LatLng position =
            LatLng(double.parse(bean.lat), double.parse(bean.lng));
        final Marker marker = Marker(
          markerId: markerId,
          position: position,
          icon: icon,
          onTap: () => markerVillageClick(bean, position),
        );
        state.markers[markerId] = marker;
      }
    } else if (state.zoomType == 3) {
      // 社区
      List<CommunityItem>? list = state.communityBean?.data.items;
      if (list == null) return;
      for (var bean in list) {
        String title = '${bean.priceUnit.price}${bean.priceUnit.unit}';
        BitmapDescriptor icon = await getIcon(title);
        MarkerId markerId = MarkerId('marker_${bean.id}');
        LatLng position =
            LatLng(double.parse(bean.lat), double.parse(bean.lng));
        final Marker marker = Marker(
          markerId: markerId,
          position: position,
          icon: icon,
          onTap: () => markerCommunityClick(bean, position),
        );
        state.markers[markerId] = marker;
      }
    }
    update();
  }

  /// 清空大头针
  void clearMarker() {
    state.markers.clear();
    update();
  }

  ///  圆形大头针
  Future<BitmapDescriptor> getRoundIcon(String title) async {
    double width = 350.w;
    double height = 350.w;

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint();

    final Radius radius = Radius.circular(height / 2);
    final rect = Rect.fromLTWH(0.0, 0.0, width, height);
    final rRect = RRect.fromRectAndCorners(
      rect,
      topLeft: radius,
      topRight: radius,
      bottomLeft: radius,
      bottomRight: radius,
    );

    //渐变色
    const gradient = RadialGradient(
      tileMode: TileMode.clamp,
      colors: [Color(0xffff4400), Color(0xffff8000)],
    );
    paint.shader = gradient.createShader(rect);
    canvas.drawRRect(rRect, paint);

    // 设置文案
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

    // 设置显示位置
    painter.paint(
      canvas,
      Offset(
        (width * 0.5) - painter.width * 0.5,
        (height * .5) - painter.height * 0.5,
      ),
    );

    // 画布转图片
    final img = await pictureRecorder.endRecording().toImage(
          width.toInt(),
          height.toInt(),
        );
    ByteData? data = await img.toByteData(format: ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  /// 大头针
  Future<BitmapDescriptor> getIcon(String title) async {
    double width = 0.8.sw;
    double height = 0.2.sw;

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final double radius = height / 2;
    double strokeWidth = 6;

    Rect rect = Rect.fromCenter(
      center: Offset(width / 2, height / 2),
      width: width,
      height: height,
    );
    RRect rRect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(radius - strokeWidth),
    );
    // Paint paintRect = Paint()
    //   ..style = PaintingStyle.fill
    //   ..strokeWidth = strokeWidth
    //   ..strokeCap = StrokeCap.round;
    //
    // //渐变色
    // const gradient = RadialGradient(
    //   tileMode: TileMode.mirror,
    //   colors: [Color(0xffff4400), Color(0xffff8000)],
    // );
    // paintRect.shader = gradient.createShader(rect);
    // canvas.drawRRect(rRect, paintRect);

    // 边框
    Paint initBorder = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    Path path = Path()
      // 上中-点
      ..moveTo(width / 2, 0)
      // 右上-线
      ..relativeLineTo(width / 2 - radius, 0)
      // 右上-弧线
      ..relativeArcToPoint(
        Offset(radius, radius),
        radius: Radius.circular(radius - strokeWidth),
      )
      //右-竖线
      ..relativeLineTo(0, height - radius * 2)
      //左下-弧线
      ..relativeArcToPoint(
        Offset(-radius, radius),
        radius: Radius.circular(radius - strokeWidth),
      )
      //下线
      ..relativeLineTo(-width + radius * 2, 0)
      //左下-弧线
      ..relativeArcToPoint(
        Offset(-radius, -radius),
        radius: Radius.circular(radius - strokeWidth),
      )
      // 左-竖线
      ..relativeLineTo(0, -height + radius * 2)
      // 左上-弧线
      ..relativeArcToPoint(
        Offset(radius, -radius),
        radius: Radius.circular(radius - strokeWidth),
      )
      // 上-线
      ..relativeLineTo(width / 2 - radius, 0)
      ..close();

    canvas.drawPath(path, initBorder);
    path.addRRect(rRect);

    // 三角形
    double sideSize = 36;
    Paint paint3 = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    Path path3 = Path();
    path3.addPolygon(
      [
        Offset(width / 2 - sideSize / 2, height),
        Offset(width / 2, height + sideSize),
        Offset(width / 2 + sideSize / 2, height),
      ],
      false,
    );
    canvas.drawPath(path3, paint3);

    TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
      ellipsis: '...',
    );
    painter.text = TextSpan(
      text: title,
      style: TextStyle(
        fontSize: 64.sp,
        color: Colors.red,
      ),
    );

    painter.layout();
    painter.paint(
      canvas,
      Offset(
        (width * 0.5) - painter.width * 0.5,
        (height * .5) - painter.height * 0.5,
      ),
    );
    final img = await pictureRecorder.endRecording().toImage(
          width.toInt(),
          height.toInt() + sideSize.toInt(),
        );
    ByteData? data = await img.toByteData(format: ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}
