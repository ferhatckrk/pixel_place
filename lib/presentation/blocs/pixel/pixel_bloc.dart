import 'dart:async';
import 'dart:ui';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:pixel_place/core/extension/offset_extension.dart';
import 'package:pixel_place/domain/repositories/pixel_repository.dart';

import '../../../data/model/pixel_model.dart';
import '../../../domain/entities/pixel.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'pixel_event.dart';
part 'pixel_state.dart';
@injectable
class PixelBloc extends Bloc<PixelEvent, PixelState> {
  final Map<int, Pixel> pixels = {};
  final List<Pixel> history = [];

  final AuthRepository _authRepository;
  final PixelRepository _pixelRepository;

  late StreamSubscription<Pixel> _pixelsSubscription;
  late StreamSubscription<Pixel> _pixelsHistorySubscription;

  StreamController pixelsController = StreamController<List<Pixel>>.broadcast();

  Stream<List<Pixel>> get pixelsStream =>
      pixelsController.stream as Stream<List<Pixel>>;

  Sink get pixelsSink => pixelsController.sink;

  StreamController pixelsHistoryController =
      StreamController<List<Pixel>>.broadcast();

  Stream<List<Pixel>> get pixelsHistoryStream =>
      pixelsHistoryController.stream as Stream<List<Pixel>>;

  Sink get pixelsHistorySink => pixelsHistoryController.sink;

  PixelBloc(this._authRepository, this._pixelRepository)
      : super(PixelsInitial()) {
    /// Pixel olaylarını dinle
    on<PixelEventListen>((event, emit) {
      _pixelsSubscription = _pixelRepository.listenPixel().listen(
        (data) {
          pixels[data.offset.hashCode] = data;
          pixelsSink.add(pixels.values.toList());
        },
        onError: (error) {
          log('Stream: $error');
        },
        cancelOnError: false,
      );
    });

    /// Pixel ekle
    on<PixelsEventAdd>((event, emit) {
      if (!_authRepository.isSigned) {
        emit(PixelsUnauthorized());
      } else {
        _pixelRepository.createPixel(PixelModel(
          offset: event.offset.round(),
          color: event.color,
          uuid: _authRepository.uid ?? 'Unknown',
          createdAt: DateTime.now(),
        ));
      }
    });

    on<PixelsHistoryEventListen>((event, emit) {
      _pixelsHistorySubscription = _pixelRepository.listenHistory().listen(
        (data) {
          history.add(data);
          pixelsHistorySink.add(history.reversed.toList());
        },
        onError: (error) {
          log('Stream: $error');
        },
        cancelOnError: false,
      );
    });
  }
  @override
  Future<void> close() {
    _pixelsSubscription.cancel();
    pixelsController.close();
    _pixelsHistorySubscription.cancel();
    pixelsHistoryController.close();
    return super.close();
  }
}
