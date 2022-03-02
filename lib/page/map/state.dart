import 'package:google_map_demo/common/bean/area_bean.dart';
import 'package:google_map_demo/common/bean/community_bean.dart';
import 'package:google_map_demo/common/bean/city_bean.dart';
import 'package:google_map_demo/common/bean/villages_bean.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  List<String> popValue = [
    '添加大头针',
    '移除大头针',
    '添加画区域',
    '移除画区域',
    '加载area数据',
    '加载社区数据',
    '底部视图',
  ];

  LatLng currentLatLng = const LatLng(25.032969370272014, 121.56541753560306);

  LatLng initLatLng = const LatLng(25.032969370272014, 121.56541753560306);

  ///缩放比例
  ///1-社區-12
  ///2-縣市-15
  ///3-鄉鎮-16
  int zoomType = 1;

  double city = 12.0;
  double village = 15.0;
  double community = 16.0;

  String areaId = '1';

  int areaType = 1;

  ///县市
  String regionId = '0';

  ///地区
  String sectionId = '0';

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

  /// 城市大头针数据
  CityBean? cityBean;

  /// 乡村大头针数据
  VillageBean? villageBean;

  /// 社区大头针数据
  CommunityBean? communityBean;

  /// 显示底部视图
  bool displayBottomView = true;
}
