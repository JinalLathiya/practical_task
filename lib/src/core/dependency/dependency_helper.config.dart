// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:practical/src/core/network/auth_api_service.dart' as _i89;
import 'package:practical/src/data/services/data_dependency.dart' as _i163;
import 'package:practical/src/data/services/local_storage_service.dart'
    as _i214;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initializeDependencies(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final dataDependency = _$DataDependency();
  await gh.lazySingletonAsync<_i214.LocalStorageService>(
    () => dataDependency.providesLocalStorageService(),
    preResolve: true,
  );
  gh.lazySingleton<_i361.Dio>(
    () => dataDependency.providesDioClient(gh<_i214.LocalStorageService>()),
  );
  gh.lazySingleton<_i89.AuthApiService>(
    () => dataDependency.providesAuthApiService(gh<_i361.Dio>()),
  );
  return getIt;
}

class _$DataDependency extends _i163.DataDependency {}
