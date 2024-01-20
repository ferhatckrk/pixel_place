// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:async/async.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:pixel_place/data/model/pixel_model.dart';

import 'package:pixel_place/domain/entities/pixel.dart';
import 'package:pixel_place/domain/repositories/pixel_repository.dart';

@Injectable(as: PixelRepository)
class FirebasePixelRepository extends PixelRepository {
  final FirebaseDatabase _database;
  FirebasePixelRepository(
    this._database,
  );
  @override
  Future<Pixel> createPixel(Pixel pixel) {
    final hash = pixel.offset.hashCode;

    return Future.wait([
      _database.ref('pixels/$hash').set(PixelModel.from(pixel).toJson()),
      _database.ref('history').push().set(PixelModel.from(pixel).toJson()),
    ]).then((value) => Future.value(pixel));
  }

  @override
  Stream<Pixel> listenHistory() => StreamGroup.merge([
        _database
            .ref('pixels')
            .orderByChild('createdAt')
            .onChildAdded
            .map((event) {
          Map<dynamic, dynamic> snapshotData = event.snapshot.value as dynamic;

/* 

           Map<Object, Object> value = event.snapshot.value  ;

          Map<String, dynamic> myMap = {
            'color': value["color"],
            'offset': {"x":value['offset'], },
            'createdAt': value['createdAt'],
            'uuid': ['uuid']
          }; */

          return PixelModel.fromJson(Map.castFrom(snapshotData));
        }),
        _database.ref('pixels').onChildChanged.map((event) {
           Map<dynamic, dynamic> snapshotData = event.snapshot.value as dynamic;
          return PixelModel.fromJson(
              Map.castFrom(snapshotData));

        }),
      ]);

  @override
  Stream<Pixel> listenPixel() =>
      _database.ref('history').limitToLast(50).onChildAdded.map((event) {
        Map<dynamic, dynamic> snapshotData = event.snapshot.value as dynamic;
        return PixelModel.fromJson(Map.castFrom(snapshotData));
      });
}
