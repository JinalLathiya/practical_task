import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:practical/src/presentation/resources/log.dart';

import 'dependency_helper.config.dart';

class DependencyHelper {
  DependencyHelper._private(this._getItInstance);

  factory DependencyHelper.createInstance([GetIt? instance]) {
    return DependencyHelper._private(instance ?? GetIt.asNewInstance());
  }

  static DependencyHelper get instance => _instance ??= DependencyHelper.createInstance();

  static DependencyHelper? _instance;
  final Completer<bool> _initializeCompleter = Completer();
  final GetIt _getItInstance;

  Future<void> initialize() async {
    try {
      if (!_initializeCompleter.isCompleted) {
        await _initializeDependencies(_getItInstance);
        _initializeCompleter.complete(true);
      }
    } catch (error, stackTrace) {
      Log.debug(error);
      Log.debug(stackTrace);
    } finally {
      await _initializeCompleter.future;
    }
  }

  T call<T extends Object>({String? instanceName}) {
    assert(_initializeCompleter.isCompleted);
    return _getItInstance<T>(instanceName: instanceName);
  }

  T get<T extends Object>({String? instanceName}) => this<T>(instanceName: instanceName);
}

@InjectableInit(initializerName: r'$initializeDependencies', asExtension: false)
FutureOr<GetIt> _initializeDependencies(GetIt getInstance) => $initializeDependencies(getInstance);
