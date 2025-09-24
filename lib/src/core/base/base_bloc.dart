import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/request_handler.dart';

abstract base class BaseBloc<Event, State> extends Bloc<Event, State> with RequestHandler {
  BaseBloc(super.initialState);

  @override
  void handleError(Object error, [StackTrace? stackTrace]) {
    onError(error, stackTrace ?? StackTrace.current);
  }
}
