import 'package:google_map_demo/common/network/safe_convert.dart';

class CommunityBean {
  final int status;
  final CommunityData data;
  final String msg;

  CommunityBean({
    this.status = 0,
    required this.data,
    this.msg = "",
  });

  factory CommunityBean.fromJson(Map<String, dynamic>? json) => CommunityBean(
        status: asInt(json, 'status'),
        data: CommunityData.fromJson(asMap(json, 'data')),
        msg: asString(json, 'msg'),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data.toJson(),
        'msg': msg,
      };
}

class CommunityData {
  final int count;
  final List<CommunityItem> items;
  final Location location;
  final Meta meta;
  final String browseNum;
  final int follow;
  final FollowNew followNew;

  CommunityData({
    this.count = 0,
    required this.items,
    required this.location,
    required this.meta,
    this.browseNum = "",
    this.follow = 0,
    required this.followNew,
  });

  factory CommunityData.fromJson(Map<String, dynamic>? json) => CommunityData(
        count: asInt(json, 'count'),
        items: asList(json, 'items').map((e) => CommunityItem.fromJson(e)).toList(),
        location: Location.fromJson(asMap(json, 'location')),
        meta: Meta.fromJson(asMap(json, 'meta')),
        browseNum: asString(json, 'browse_num'),
        follow: asInt(json, 'follow'),
        followNew: FollowNew.fromJson(asMap(json, 'follow_new')),
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

class CommunityItem {
  final int sectionId;
  final String sectionName;
  final int count;
  final String lat;
  final String lng;
  final PriceUnit priceUnit;
  final String gatherLat;
  final String gatherLng;
  final int regionId;
  final String regionName;
  final int shopCount;
  final String distance;

  CommunityItem({
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

  factory CommunityItem.fromJson(Map<String, dynamic>? json) => CommunityItem(
        sectionId: asInt(json, 'sectionid'),
        sectionName: asString(json, 'section_name'),
        count: asInt(json, 'count'),
        lat: asString(json, 'lat'),
        lng: asString(json, 'lng'),
        priceUnit: PriceUnit.fromJson(asMap(json, 'price_unit')),
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

class Location {
  final Region region;
  final Section section;

  Location({
    required this.region,
    required this.section,
  });

  factory Location.fromJson(Map<String, dynamic>? json) => Location(
        region: Region.fromJson(asMap(json, 'region')),
        section: Section.fromJson(asMap(json, 'section')),
      );

  Map<String, dynamic> toJson() => {
        'region': region.toJson(),
        'section': section.toJson(),
      };
}

class Region {
  final int id;
  final String name;

  Region({
    this.id = 0,
    this.name = "",
  });

  factory Region.fromJson(Map<String, dynamic>? json) => Region(
        id: asInt(json, 'id'),
        name: asString(json, 'name'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class Section {
  final int id;
  final String name;

  Section({
    this.id = 0,
    this.name = "",
  });

  factory Section.fromJson(Map<String, dynamic>? json) => Section(
        id: asInt(json, 'id'),
        name: asString(json, 'name'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
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

class FollowNew {
  final int count;
  final String str;

  FollowNew({
    this.count = 0,
    this.str = "",
  });

  factory FollowNew.fromJson(Map<String, dynamic>? json) => FollowNew(
        count: asInt(json, 'count'),
        str: asString(json, 'str'),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'str': str,
      };
}
