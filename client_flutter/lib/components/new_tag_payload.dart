import 'package:json_annotation/json_annotation.dart';
part 'new_tag_payload.g.dart';

@JsonSerializable()
class NewTagPayload {
  final String lat;
  final String lon;
  final String range;
  final String type;

  NewTagPayload(
      {required this.lat,
      required this.lon,
      required this.type,
      required this.range});

  Map<String, dynamic> toJson() => _$NewTagPayloadToJson(this);
}
