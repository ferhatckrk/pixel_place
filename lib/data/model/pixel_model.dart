import 'package:json_annotation/json_annotation.dart';

import 'package:pixel_place/data/converters/color_converter.dart';
import 'package:pixel_place/data/converters/date_time_converter.dart';
import 'package:pixel_place/data/converters/offset_converter.dart';
import 'package:pixel_place/domain/entities/pixel.dart';
part 'pixel_model.g.dart';

@JsonSerializable(explicitToJson: true)
@OffsetConverter()
@ColorConverter()
@DateTimeConverter()
class PixelModel extends Pixel {
  const PixelModel(
      {required super.offset,
      required super.color,
      required super.uuid,
      required super.createdAt});

  factory PixelModel.from(Pixel other) => PixelModel(
        offset: other.offset,
        color: other.color,
        uuid: other.uuid,
        createdAt: other.createdAt,
      );

  factory PixelModel.fromJson(Map<String, dynamic> json) {
    Map<dynamic, dynamic> snapshotData = json as dynamic;

    return _$PixelModelFromJson(Map.castFrom(snapshotData));
  }

  Map<String, dynamic> toJson() => _$PixelModelToJson(this);
}
