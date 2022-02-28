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
  final String searchBrowseNum;
  final CommunityMeta meta;
  final String browseNum;

  CommunityData({
    this.count = 0,
    required this.items,
    this.searchBrowseNum = "",
    required this.meta,
    this.browseNum = "",
  });

  factory CommunityData.fromJson(Map<String, dynamic>? json) => CommunityData(
        count: asInt(json, 'count'),
        items: asList(json, 'items')
            .map((e) => CommunityItem.fromJson(e))
            .toList(),
        searchBrowseNum: asString(json, 'search_browse_num'),
        meta: CommunityMeta.fromJson(asMap(json, 'meta')),
        browseNum: asString(json, 'browse_num'),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'items': items.map((e) => e.toJson()),
        'search_browse_num': searchBrowseNum,
        'meta': meta.toJson(),
        'browse_num': browseNum,
      };
}

class CommunityItem {
  final int id;
  final String name;
  final int regionId;
  final int sectionId;
  final int streetId;
  final String street;
  final int buildType;
  final String buildPurposeSimple;
  final int houseHolds;
  final String age;
  final String region;
  final String section;
  final String address;
  final String simpleAddress;
  final CommunityPriceUnit priceUnit;
  final CommunitySellPriceUnit sellPriceUnit;
  final String saleNum;
  final String browseNum;
  final String lat;
  final String lng;
  final int followStatus;
  final int housingType;
  final String sellPrice;
  final CommunityShowSellPrice showSellPrice;
  final int hid;
  final int hasSaleCtrl;
  final CommunityPhotoSrc photoSrc;
  final String housingTypeStr;
  final List<CommunityTagItem> tag;
  final CommunityPrice price;
  final List<String> buildInfo;

  CommunityItem({
    this.id = 0,
    this.name = "",
    this.regionId = 0,
    this.sectionId = 0,
    this.streetId = 0,
    this.street = "",
    this.buildType = 0,
    this.buildPurposeSimple = "",
    this.houseHolds = 0,
    this.age = "",
    this.region = "",
    this.section = "",
    this.address = "",
    this.simpleAddress = "",
    required this.priceUnit,
    required this.sellPriceUnit,
    this.saleNum = "",
    this.browseNum = "",
    this.lat = "",
    this.lng = "",
    this.followStatus = 0,
    this.housingType = 0,
    this.sellPrice = '',
    required this.showSellPrice,
    this.hid = 0,
    this.hasSaleCtrl = 0,
    required this.photoSrc,
    this.housingTypeStr = "",
    required this.tag,
    required this.price,
    required this.buildInfo,
  });

  factory CommunityItem.fromJson(Map<String, dynamic>? json) => CommunityItem(
        id: asInt(json, 'id'),
        name: asString(json, 'name'),
        regionId: asInt(json, 'regionid'),
        sectionId: asInt(json, 'sectionid'),
        streetId: asInt(json, 'streetid'),
        street: asString(json, 'street'),
        buildType: asInt(json, 'build_type'),
        buildPurposeSimple: asString(json, 'build_purpose_simple'),
        houseHolds: asInt(json, 'house_holds'),
        age: asString(json, 'age'),
        region: asString(json, 'region'),
        section: asString(json, 'section'),
        address: asString(json, 'address'),
        simpleAddress: asString(json, 'simple_address'),
        priceUnit: CommunityPriceUnit.fromJson(asMap(json, 'price_unit')),
        sellPriceUnit:
            CommunitySellPriceUnit.fromJson(asMap(json, 'sell_price_unit')),
        saleNum: asString(json, 'sale_num'),
        browseNum: asString(json, 'browse_num'),
        lat: asString(json, 'lat'),
        lng: asString(json, 'lng'),
        followStatus: asInt(json, 'follow_status'),
        housingType: asInt(json, 'housing_type'),
        sellPrice: asString(json, 'sell_price'),
        showSellPrice:
            CommunityShowSellPrice.fromJson(asMap(json, 'show_sell_price')),
        hid: asInt(json, 'hid'),
        hasSaleCtrl: asInt(json, 'has_sale_ctrl'),
        photoSrc: CommunityPhotoSrc.fromJson(asMap(json, 'photo_src')),
        housingTypeStr: asString(json, 'housing_type_str'),
        tag: asList(json, 'tag')
            .map((e) => CommunityTagItem.fromJson(e))
            .toList(),
        price: CommunityPrice.fromJson(asMap(json, 'price')),
        buildInfo: asList(json, 'build_info').map((e) => e.toString()).toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'regionid': regionId,
        'sectionid': sectionId,
        'streetid': streetId,
        'street': street,
        'build_type': buildType,
        'build_purpose_simple': buildPurposeSimple,
        'house_holds': houseHolds,
        'age': age,
        'region': region,
        'section': section,
        'address': address,
        'simple_address': simpleAddress,
        'price_unit': priceUnit.toJson(),
        'sell_price_unit': sellPriceUnit.toJson(),
        'sale_num': saleNum,
        'browse_num': browseNum,
        'lat': lat,
        'lng': lng,
        'follow_status': followStatus,
        'housing_type': housingType,
        'sell_price': sellPrice,
        'show_sell_price': showSellPrice.toJson(),
        'hid': hid,
        'has_sale_ctrl': hasSaleCtrl,
        'photo_src': photoSrc.toJson(),
        'housing_type_str': housingTypeStr,
        'tag': tag.map((e) => e.toJson()),
        'price': price.toJson(),
        'build_info': buildInfo.map((e) => e),
      };
}

class CommunityPriceUnit {
  final String price;
  final String unit;
  final String str;

  CommunityPriceUnit({
    this.price = "",
    this.unit = "",
    this.str = "",
  });

  factory CommunityPriceUnit.fromJson(Map<String, dynamic>? json) =>
      CommunityPriceUnit(
        price: asString(json, 'price'),
        unit: asString(json, 'unit'),
        str: asString(json, 'str'),
      );

  Map<String, dynamic> toJson() => {
        'price': price,
        'unit': unit,
        'str': str,
      };
}

class CommunitySellPriceUnit {
  final String title;
  final String price;
  final String unit;
  final String str;
  final String rate;

  CommunitySellPriceUnit({
    this.title = "",
    this.price = "",
    this.unit = "",
    this.str = "",
    this.rate = "",
  });

  factory CommunitySellPriceUnit.fromJson(Map<String, dynamic>? json) =>
      CommunitySellPriceUnit(
        title: asString(json, 'title'),
        price: asString(json, 'price'),
        unit: asString(json, 'unit'),
        str: asString(json, 'str'),
        rate: asString(json, 'rate'),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'price': price,
        'unit': unit,
        'str': str,
        'rate': rate,
      };
}

class CommunityShowSellPrice {
  final String title;
  final String price;
  final String unit;
  final String str;
  final String rate;

  CommunityShowSellPrice({
    this.title = "",
    this.price = "",
    this.unit = "",
    this.str = "",
    this.rate = "",
  });

  factory CommunityShowSellPrice.fromJson(Map<String, dynamic>? json) =>
      CommunityShowSellPrice(
        title: asString(json, 'title'),
        price: asString(json, 'price'),
        unit: asString(json, 'unit'),
        str: asString(json, 'str'),
        rate: asString(json, 'rate'),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'price': price,
        'unit': unit,
        'str': str,
        'rate': rate,
      };
}

class CommunityPhotoSrc {
  final int type;
  final String src;

  CommunityPhotoSrc({
    this.type = 0,
    this.src = "",
  });

  factory CommunityPhotoSrc.fromJson(Map<String, dynamic>? json) =>
      CommunityPhotoSrc(
        type: asInt(json, 'type'),
        src: asString(json, 'src'),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'src': src,
      };
}

class CommunityTagItem {
  final int tagType;
  final String tagStr;

  CommunityTagItem({
    this.tagType = 0,
    this.tagStr = "",
  });

  factory CommunityTagItem.fromJson(Map<String, dynamic>? json) =>
      CommunityTagItem(
        tagType: asInt(json, 'tag_type'),
        tagStr: asString(json, 'tag_str'),
      );

  Map<String, dynamic> toJson() => {
        'tag_type': tagType,
        'tag_str': tagStr,
      };
}

class CommunityPrice {
  final String price;
  final String unit;
  final String text;

  CommunityPrice({
    this.price = "",
    this.unit = "",
    this.text = "",
  });

  factory CommunityPrice.fromJson(Map<String, dynamic>? json) => CommunityPrice(
        price: asString(json, 'price'),
        unit: asString(json, 'unit'),
        text: asString(json, 'text'),
      );

  Map<String, dynamic> toJson() => {
        'price': price,
        'unit': unit,
        'text': text,
      };
}

class CommunityMeta {
  final String title;
  final String keywords;
  final String description;

  CommunityMeta({
    this.title = "",
    this.keywords = "",
    this.description = "",
  });

  factory CommunityMeta.fromJson(Map<String, dynamic>? json) => CommunityMeta(
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
