import 'package:flutter/foundation.dart';

class Tag {
  final double lat;
  final double lng;
  final String type;
  final int range;

  Tag({
    required this.lat,
    required this.lng,
    required this.type,
    required this.range,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      lat: json['lat'] as double,
      lng: json['lng'] as double,
      type: json['type'] as String,
      range: json['range'] as int,
    );
  }
}
