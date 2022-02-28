import 'package:google_map_demo/common/network/safe_convert.dart';

class AreaBean {
  final int status;
  final String msg;
  final Data data;

  AreaBean({
    this.status = 0,
    this.msg = "",
    required this.data,
  });

  factory AreaBean.fromJson(Map<String, dynamic>? json) => AreaBean(
        status: asInt(json, 'status'),
        msg: asString(json, 'msg'),
        data: Data.fromJson(asMap(json, 'data')),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'msg': msg,
        'data': data.toJson(),
      };
}

class Data {
  final int type;
  final int areaId;
  final String name;
  final String enName;
  final int isMult;
  final List<AreaLatLng> geoBoundingBox;

  Data({
    this.type = 0,
    this.areaId = 0,
    this.name = "",
    this.enName = "",
    this.isMult = 0,
    required this.geoBoundingBox,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
        type: asInt(json, 'type'),
        areaId: asInt(json, 'area_id'),
        name: asString(json, 'name'),
        enName: asString(json, 'en_name'),
        isMult: asInt(json, 'is_mult'),
        geoBoundingBox: asList(json, 'geo_bounding_box')
            .map((e) => AreaLatLng('${e[0]}', '${e[1]}'))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'area_id': areaId,
        'name': name,
        'en_name': enName,
        'is_mult': isMult,
        'geo_bounding_box': geoBoundingBox.map((e) => e),
      };
}

class AreaLatLng {
  final String lat;
  final String lng;

  AreaLatLng(this.lat, this.lng);
}
