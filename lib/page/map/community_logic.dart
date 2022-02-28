import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map_demo/common/api/api.dart';
import 'package:google_map_demo/common/bean/community_bean.dart';
import 'package:google_map_demo/common/logger/logger_utils.dart';
import 'package:google_map_demo/common/network/http_request.dart';
import 'package:google_map_demo/page/map/logic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension CommunityLogic on MapLogic {
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
        // 绘制圆
        drawMarker();
      },
    );
  }

  /// 增加大头针
  void drawMarker() async {
    if (state.markers.isNotEmpty) {
      state.markers.clear();
    } else {
      //自定义大头针
      List<CommunityItem> list = state.communityBean.data.items;
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
          onTap: () {
            Logger.write('大头针: ${markerId.value}');

          },
        );
        state.markers[markerId] = marker;
      }
    }
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
