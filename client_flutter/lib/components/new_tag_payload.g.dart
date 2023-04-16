// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_tag_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewTagPayload _$NewTagPayloadFromJson(Map<String, dynamic> json) =>
    NewTagPayload(
      lat: json['lat'] as String,
      lng: json['lng'] as String,
      type: json['type'] as String,
      range: json['range'] as String,
      desc: json['desc'] as String,
      date: json['date'] as String,
      up: json['up'] as String,
      down: json['down'] as String,
    );

Map<String, dynamic> _$NewTagPayloadToJson(NewTagPayload instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'range': instance.range,
      'type': instance.type,
      'desc': instance.desc,
      'date': instance.date,
      'up': instance.up,
      'down': instance.down,
    };
