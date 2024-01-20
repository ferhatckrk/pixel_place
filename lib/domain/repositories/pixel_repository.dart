import 'package:pixel_place/domain/entities/pixel.dart';

abstract class PixelRepository {
  Stream<Pixel> listenPixel();
  Stream<Pixel> listenHistory();
  Future<Pixel> createPixel(Pixel pixel);

}
