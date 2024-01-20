// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_database/firebase_database.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/di/firebase_module.dart' as _i11;
import 'data/repositories/firebase_auth_repository.dart' as _i8;
import 'data/repositories/firebase_pixel_repository.dart' as _i6;
import 'domain/repositories/auth_repository.dart' as _i7;
import 'domain/repositories/pixel_repository.dart' as _i5;
import 'presentation/blocs/auth/auth_cubit.dart' as _i10;
import 'presentation/blocs/pixel/pixel_bloc.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final firebaseModule = _$FirebaseModule();
  gh.singleton<_i3.FirebaseAuth>(firebaseModule.provideFirebaseAuth());
  await gh.singletonAsync<_i4.FirebaseDatabase>(
    () => firebaseModule.provideFirebaseProdDatabase(),
    preResolve: true,
  );
  gh.factory<_i5.PixelRepository>(
      () => _i6.FirebasePixelRepository(get<_i4.FirebaseDatabase>()));
  gh.factory<_i7.AuthRepository>(
      () => _i8.FirebaseAuthRepository(get<_i3.FirebaseAuth>()));
  gh.factory<_i9.PixelBloc>(() => _i9.PixelBloc(
        get<_i7.AuthRepository>(),
        get<_i5.PixelRepository>(),
      ));
  gh.factory<_i10.AuthCubit>(() => _i10.AuthCubit(get<_i7.AuthRepository>()));
  return get;
}

class _$FirebaseModule extends _i11.FirebaseModule {}
