import 'package:flutter/foundation.dart';

class Tag {
  final double lat;
  final double lng;
  final String type;
  final int range;
  final String desc;
  final String date;
  final int up;
  final int down;

  Tag({
    required this.lat,
    required this.lng,
    required this.type,
    required this.range,
    required this.desc,
    required this.date,
    required this.up,
    required this.down,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      lat: json['lat'] as double,
      lng: json['lng'] as double,
      type: json['type'] as String,
      range: json['range'] as int,
      desc: json['desc'] as String,
      date: json['date'] as String,
      up: json['up'] as int,
      down: json['down'] as int,
    );
  }
}
