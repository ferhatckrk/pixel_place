import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixel_place/domain/entities/pixel.dart';
import 'package:pixel_place/presentation/blocs/pixel/pixel_bloc.dart';
import 'my_painter.dart';

class CanvasViewer extends StatelessWidget {
  CanvasViewer({
    Key? key,
    required this.pixelsBloc,
    required this.color,
    required this.pixels,
  }) : super(key: key);

  final PixelBloc pixelsBloc;
  final List<Pixel> pixels;
  final Color color;

  bool isMove = false;
  Offset onTapDownOffset = Offset.zero;
  Offset onTapUpOffset = Offset.zero;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return InteractiveViewer(
      constrained: false,
      minScale: 0.2,
      maxScale: 15,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Listener(
          onPointerUp: (event) {
            onTapUpOffset = event.localPosition;
            if (onTapDownOffset == onTapUpOffset) {
              if (RawKeyboard.instance.keysPressed.isEmpty) {
                pixelsBloc.add(PixelsEventAdd(
                  event.localPosition,
                  color,
                ));
              }
            }
          },
          onPointerDown: (event) {
            onTapDownOffset = event.localPosition;

            /* if (RawKeyboard.instance.keysPressed.isEmpty) {
                pixelsBloc.add(PixelsEventAdd(
                  event.localPosition,
                  color,
                ));
              }  */
          },
          child: CustomPaint(
            size:   Size(size.width, size.height),
            painter: MyPainter(
              pixels: pixels,
            ),
          ),
        ),
      ),
    );
  }
}
