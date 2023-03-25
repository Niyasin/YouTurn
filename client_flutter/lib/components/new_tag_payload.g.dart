// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_tag_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewTagPayload _$NewTagPayloadFromJson(Map<String, dynamic> json) =>
    NewTagPayload(
      lat: json['lat'] as String,
      lon: json['lon'] as String,
      type: json['type'] as String,
      range: json['range'] as String,
    );

Map<String, dynamic> _$NewTagPayloadToJson(NewTagPayload instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'range': instance.range,
      'type': instance.type,
    };
