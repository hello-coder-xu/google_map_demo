import 'package:google_map_demo/common/network/safe_convert.dart';

class CityBean {
  final int status;
  final CityData data;
  final String msg;

  CityBean({
    this.status = 0,
    required this.data,
    this.msg = "",
  });

  factory CityBean.fromJson(Map<String, dynamic>? json) => CityBean(
        status: asInt(json, 'status'),
        data: CityData.fromJson(asMap(json, 'data')),
        msg: asString(json, 'msg'),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data.toJson(),
        'msg': msg,
      };
}

class CityData {
  final int count;
  final List<CityItem> items;
  final CityLocation location;
  final CityMeta meta;
  final String browseNum;
  final int follow;
  final CityFollowNew followNew;

  CityData({
    this.count = 0,
    required this.items,
    required this.location,
    required this.meta,
    this.browseNum = "",
    this.follow = 0,
    required this.followNew,
  });

  factory CityData.fromJson(Map<String, dynamic>? json) => CityData(
        count: asInt(json, 'count'),
        items: asList(json, 'items').map((e) => CityItem.fromJson(e)).toList(),
        location: CityLocation.fromJson(asMap(json, 'location')),
        meta: CityMeta.fromJson(asMap(json, 'meta')),
        browseNum: asString(json, 'browse_num'),
        follow: asInt(json, 'follow'),
        followNew: CityFollowNew.fromJson(asMap(json, 'follow_new')),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'items': items.map((e) => e.toJson()),
        'location': location.toJson(),
        'meta': meta.toJson(),
        'browse_num': browseNum,
        'follow': follow,
        'follow_new': followNew.toJson(),
      };
}

class CityItem {
  final int sectionId;
  final String sectionName;
  final int count;
  final String lat;
  final String lng;
  final CityPriceUnit priceUnit;
  final String gatherLat;
  final String gatherLng;
  final int regionId;
  final String regionName;
  final int shopCount;
  final String distance;

  CityItem({
    this.sectionId = 0,
    this.sectionName = "",
    this.count = 0,
    this.lat = "",
    this.lng = "",
    required this.priceUnit,
    this.gatherLat = "",
    this.gatherLng = "",
    this.regionId = 0,
    this.regionName = "",
    this.shopCount = 0,
    this.distance = "",
  });

  factory CityItem.fromJson(Map<String, dynamic>? json) => CityItem(
        sectionId: asInt(json, 'sectionid'),
        sectionName: asString(json, 'section_name'),
        count: asInt(json, 'count'),
        lat: asString(json, 'lat'),
        lng: asString(json, 'lng'),
        priceUnit: CityPriceUnit.fromJson(asMap(json, 'price_unit')),
        gatherLat: asString(json, 'gather_lat'),
        gatherLng: asString(json, 'gather_lng'),
        regionId: asInt(json, 'regionid'),
        regionName: asString(json, 'region_name'),
        shopCount: asInt(json, 'shop_count'),
        distance: asString(json, 'distance'),
      );

  Map<String, dynamic> toJson() => {
        'sectionid': sectionId,
        'section_name': sectionName,
        'count': count,
        'lat': lat,
        'lng': lng,
        'price_unit': priceUnit.toJson(),
        'gather_lat': gatherLat,
        'gather_lng': gatherLng,
        'regionid': regionId,
        'region_name': regionName,
        'shop_count': shopCount,
        'distance': distance,
      };
}

class CityPriceUnit {
  final String price;
  final String unit;

  CityPriceUnit({
    this.price = "",
    this.unit = "",
  });

  factory CityPriceUnit.fromJson(Map<String, dynamic>? json) => CityPriceUnit(
        price: asString(json, 'price'),
        unit: asString(json, 'unit'),
      );

  Map<String, dynamic> toJson() => {
        'price': price,
        'unit': unit,
      };
}

class CityLocation {
  final CityRegion region;
  final CitySection section;

  CityLocation({
    required this.region,
    required this.section,
  });

  factory CityLocation.fromJson(Map<String, dynamic>? json) => CityLocation(
        region: CityRegion.fromJson(asMap(json, 'region')),
        section: CitySection.fromJson(asMap(json, 'section')),
      );

  Map<String, dynamic> toJson() => {
        'region': region.toJson(),
        'section': section.toJson(),
      };
}

class CityRegion {
  final int id;
  final String name;

  CityRegion({
    this.id = 0,
    this.name = "",
  });

  factory CityRegion.fromJson(Map<String, dynamic>? json) => CityRegion(
        id: asInt(json, 'id'),
        name: asString(json, 'name'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class CitySection {
  final int id;
  final String name;

  CitySection({
    this.id = 0,
    this.name = "",
  });

  factory CitySection.fromJson(Map<String, dynamic>? json) => CitySection(
        id: asInt(json, 'id'),
        name: asString(json, 'name'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class CityMeta {
  final String title;
  final String keywords;
  final String description;

  CityMeta({
    this.title = "",
    this.keywords = "",
    this.description = "",
  });

  factory CityMeta.fromJson(Map<String, dynamic>? json) => CityMeta(
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

class CityFollowNew {
  final int count;
  final String str;

  CityFollowNew({
    this.count = 0,
    this.str = "",
  });

  factory CityFollowNew.fromJson(Map<String, dynamic>? json) => CityFollowNew(
        count: asInt(json, 'count'),
        str: asString(json, 'str'),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'str': str,
      };
}
