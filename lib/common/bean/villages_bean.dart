import 'package:google_map_demo/common/network/safe_convert.dart';

class VillageBean {
  final int status;
  final Data data;
  final String msg;

  VillageBean({
    this.status = 0,
    required this.data,
    this.msg = "",
  });

  factory VillageBean.fromJson(Map<String, dynamic>? json) => VillageBean(
        status: asInt(json, 'status'),
        data: Data.fromJson(asMap(json, 'data')),
        msg: asString(json, 'msg'),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data.toJson(),
        'msg': msg,
      };
}

class Data {
  final int count;
  final List<VillageItem> items;
  final Meta meta;
  final String browseNum;

  Data({
    this.count = 0,
    required this.items,
    required this.meta,
    this.browseNum = "",
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
        count: asInt(json, 'count'),
        items: asList(json, 'items').map((e) => VillageItem.fromJson(e)).toList(),
        meta: Meta.fromJson(asMap(json, 'meta')),
        browseNum: asString(json, 'browse_num'),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'items': items.map((e) => e.toJson()),
        'meta': meta.toJson(),
        'browse_num': browseNum,
      };
}

class VillageItem {
  final int shopId;
  final String shopName;
  final int count;
  final String lat;
  final String lng;
  final PriceUnit priceUnit;
  final String gatherLat;
  final String gatherLng;

  VillageItem({
    this.shopId = 0,
    this.shopName = "",
    this.count = 0,
    this.lat = "",
    this.lng = "",
    required this.priceUnit,
    this.gatherLat = "",
    this.gatherLng = "",
  });

  factory VillageItem.fromJson(Map<String, dynamic>? json) => VillageItem(
        shopId: asInt(json, 'shopid'),
        shopName: asString(json, 'shop_name'),
        count: asInt(json, 'count'),
        lat: asString(json, 'lat'),
        lng: asString(json, 'lng'),
        priceUnit: PriceUnit.fromJson(asMap(json, 'price_unit')),
        gatherLat: asString(json, 'gather_lat'),
        gatherLng: asString(json, 'gather_lng'),
      );

  Map<String, dynamic> toJson() => {
        'shopid': shopId,
        'shop_name': shopName,
        'count': count,
        'lat': lat,
        'lng': lng,
        'price_unit': priceUnit.toJson(),
        'gather_lat': gatherLat,
        'gather_lng': gatherLng,
      };
}

class PriceUnit {
  final String price;
  final String unit;

  PriceUnit({
    this.price = "",
    this.unit = "",
  });

  factory PriceUnit.fromJson(Map<String, dynamic>? json) => PriceUnit(
        price: asString(json, 'price'),
        unit: asString(json, 'unit'),
      );

  Map<String, dynamic> toJson() => {
        'price': price,
        'unit': unit,
      };
}

class Meta {
  final String title;
  final String keywords;
  final String description;

  Meta({
    this.title = "",
    this.keywords = "",
    this.description = "",
  });

  factory Meta.fromJson(Map<String, dynamic>? json) => Meta(
        title: asString(json, 'title'),
        keywords: asString(json, 'keywords'),
        description: asString(json, 'description'),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'keywords': keywords,
        'description': description,
      };
}
