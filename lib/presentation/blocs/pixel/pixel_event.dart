part of 'pixel_bloc.dart';

@immutable
abstract class PixelEvent {}

class PixelEventListen extends PixelEvent {}

class PixelsHistoryEventListen extends PixelEvent {}

class PixelsEventAdd extends PixelEvent {
  final Offset offset;
  final Color color;

  PixelsEventAdd(this.offset, this.color);
}
