import 'package:json_annotation/json_annotation.dart';
part 'new_tag_payload.g.dart';

@JsonSerializable()
class NewTagPayload {
  final String lat;
  final String lng;
  final String range;
  final String type;
  final String desc;
  final String date;
  final String up;
  final String down;

  NewTagPayload({
    required this.lat,
    required this.lng,
    required this.type,
    required this.range,
    required this.desc,
    required this.date,
    required this.up,
    required this.down,
  });

  Map<String, dynamic> toJson() => _$NewTagPayloadToJson(this);
}
