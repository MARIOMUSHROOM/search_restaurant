// To parse this JSON data, do
//
//     final mapModel = mapModelFromJson(jsonString);

import 'dart:convert';

MapModel mapModelFromJson(String str) => MapModel.fromJson(json.decode(str));

String mapModelToJson(MapModel data) => json.encode(data.toJson());

class MapModel {
  MapModel({
    this.htmlAttributions,
    this.nextPageToken,
    this.results,
  });

  List<dynamic>? htmlAttributions;
  String? nextPageToken;
  List<Result>? results;

  factory MapModel.fromJson(Map<String, dynamic> json) => MapModel(
        htmlAttributions: json["html_attributions"] == null
            ? null
            : List<dynamic>.from(json["html_attributions"].map((x) => x)),
        nextPageToken:
            json["next_page_token"] == null ? null : json["next_page_token"],
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "html_attributions": htmlAttributions == null
            ? null
            : List<dynamic>.from(htmlAttributions!.map((x) => x)),
        "next_page_token": nextPageToken == null ? null : nextPageToken,
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.businessStatus,
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.plusCode,
    this.priceLevel,
    this.rating,
    this.reference,
    this.types,
    this.userRatingsTotal,
  });

  String? businessStatus;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  OpeningHours? openingHours;
  List<Photo>? photos;
  String? placeId;
  PlusCode? plusCode;
  int? priceLevel;
  double? rating;
  String? reference;
  List<String>? types;
  int? userRatingsTotal;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        businessStatus:
            json["business_status"] == null ? null : json["business_status"],
        formattedAddress: json["formatted_address"] == null
            ? null
            : json["formatted_address"],
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        icon: json["icon"] == null ? null : json["icon"],
        iconBackgroundColor: json["icon_background_color"] == null
            ? null
            : json["icon_background_color"],
        iconMaskBaseUri: json["icon_mask_base_uri"] == null
            ? null
            : json["icon_mask_base_uri"],
        name: json["name"] == null ? null : json["name"],
        openingHours: json["opening_hours"] == null
            ? null
            : OpeningHours.fromJson(json["opening_hours"]),
        photos: json["photos"] == null
            ? null
            : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        placeId: json["place_id"] == null ? null : json["place_id"],
        plusCode: json["plus_code"] == null
            ? null
            : PlusCode.fromJson(json["plus_code"]),
        priceLevel: json["price_level"] == null ? null : json["price_level"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        reference: json["reference"] == null ? null : json["reference"],
        types: json["types"] == null
            ? null
            : List<String>.from(json["types"].map((x) => x)),
        userRatingsTotal: json["user_ratings_total"] == null
            ? null
            : json["user_ratings_total"],
      );

  Map<String, dynamic> toJson() => {
        "business_status": businessStatus == null ? null : businessStatus,
        "formatted_address": formattedAddress == null ? null : formattedAddress,
        "geometry": geometry == null ? null : geometry!.toJson(),
        "icon": icon == null ? null : icon,
        "icon_background_color":
            iconBackgroundColor == null ? null : iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri == null ? null : iconMaskBaseUri,
        "name": name == null ? null : name,
        "opening_hours": openingHours == null ? null : openingHours!.toJson(),
        "photos": photos == null
            ? null
            : List<dynamic>.from(photos!.map((x) => x.toJson())),
        "place_id": placeId == null ? null : placeId,
        "plus_code": plusCode == null ? null : plusCode!.toJson(),
        "price_level": priceLevel == null ? null : priceLevel,
        "rating": rating == null ? null : rating,
        "reference": reference == null ? null : reference,
        "types":
            types == null ? null : List<dynamic>.from(types!.map((x) => x)),
        "user_ratings_total":
            userRatingsTotal == null ? null : userRatingsTotal,
      };
}

class Geometry {
  Geometry({
    this.location,
    this.viewport,
  });

  Location? location;
  Viewport? viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        viewport: json["viewport"] == null
            ? null
            : Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location == null ? null : location!.toJson(),
        "viewport": viewport == null ? null : viewport!.toJson(),
      };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  Location? northeast;
  Location? southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: json["northeast"] == null
            ? null
            : Location.fromJson(json["northeast"]),
        southwest: json["southwest"] == null
            ? null
            : Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast == null ? null : northeast!.toJson(),
        "southwest": southwest == null ? null : southwest!.toJson(),
      };
}

class OpeningHours {
  OpeningHours({
    this.openNow,
  });

  bool? openNow;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"] == null ? null : json["open_now"],
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow == null ? null : openNow,
      };
}

class Photo {
  Photo({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"] == null ? null : json["height"],
        htmlAttributions: json["html_attributions"] == null
            ? null
            : List<String>.from(json["html_attributions"].map((x) => x)),
        photoReference:
            json["photo_reference"] == null ? null : json["photo_reference"],
        width: json["width"] == null ? null : json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height == null ? null : height,
        "html_attributions": htmlAttributions == null
            ? null
            : List<dynamic>.from(htmlAttributions!.map((x) => x)),
        "photo_reference": photoReference == null ? null : photoReference,
        "width": width == null ? null : width,
      };
}

class PlusCode {
  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  String? compoundCode;
  String? globalCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode:
            json["compound_code"] == null ? null : json["compound_code"],
        globalCode: json["global_code"] == null ? null : json["global_code"],
      );

  Map<String, dynamic> toJson() => {
        "compound_code": compoundCode == null ? null : compoundCode,
        "global_code": globalCode == null ? null : globalCode,
      };
}
