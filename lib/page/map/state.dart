import 'package:google_map_demo/common/bean/community_bean.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../common/bean/area_bean.dart';

class MapState {
  List<String> popValue = ['台北', '大头针', '画区域', '画圆', '加载area数据', '加载社区数据'];

  LatLng currentLatLng = const LatLng(25.032969370272014, 121.56541753560306);

  LatLng initLatLng = const LatLng(25.032969370272014, 121.56541753560306);

  ///缩放比例
  double zoom = 12.0;

  double region = 11.0;
  double section = 12.0;
  double shop = 15.0;
  double marketPrice = 16.0;
  double marketName = 16.5;
  double singleBuild = 19.5;

  /// 地图控制器
  GoogleMapController? controller;

  ///初始坐标
  late CameraPosition kInitialPosition;

  /// 大头针
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  ///区域
  Map<PolygonId, Polygon> polygons = <PolygonId, Polygon>{};

  ///线路
  Map<PolylineId, Polyline> polyLines = <PolylineId, Polyline>{};

  /// 圆
  Map<CircleId, Circle> circles = <CircleId, Circle>{};

  ///图层
  Map<TileOverlayId, TileOverlay> tileOverlays = <TileOverlayId, TileOverlay>{};

  /// 地区范围
  late AreaBean areaBean;

  /// 社区数据
  late CommunityBean communityBean;
}
