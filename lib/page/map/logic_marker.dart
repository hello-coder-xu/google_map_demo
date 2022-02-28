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
      'regionid': state.regionId,
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
    state.markers.clear();

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
        String title = bean.name;
        BitmapDescriptor icon = await getRoundIcon(title);
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

      update();
    }
  }

  /// 清空大头针
  void clearMarker() {
    state.markers.clear();
    update();
  }

  ///
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
