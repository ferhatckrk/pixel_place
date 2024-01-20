import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pixel_place/core/di/injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<GetIt> configureDependencies(String env) => $initGetIt(
      getIt,
      environment: env,
    );
