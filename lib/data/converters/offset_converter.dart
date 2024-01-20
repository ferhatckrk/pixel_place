import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class OffsetConverter implements JsonConverter<Offset, Map<String, dynamic>> {
  const OffsetConverter();

  @override
  Offset fromJson(Map  json) => Offset( double.parse (json['x'].toString()) , double.parse (json['y'].toString()));

  @override
  Map<String, dynamic> toJson(Offset offset) =>
      {'x': offset.dx, 'y': offset.dy};
}
