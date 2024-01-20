import 'dart:ui';

extension OffsetExtension on Offset {
  Offset round() => Offset(
        (dx - dx.remainder(5)).truncateToDouble(),
        (dy - dy.remainder(5)).truncateToDouble(),
      );
}
