part of 'pixel_bloc.dart';

@immutable
abstract class PixelState extends Equatable {
  @override
  List<Object> get props => [];
}

class PixelsInitial extends PixelState {}

class PixelsLoading extends PixelState {}

class PixelsLoaded extends PixelState {
  final List<Pixel> pixels;

  PixelsLoaded(this.pixels);

  @override
  List<Object> get props => [pixels];
}

class PixelsUnauthorized extends PixelState {}
