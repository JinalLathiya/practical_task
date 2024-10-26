import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/home_view/time_range_list/time_range_list.dart';

final class TimeRangeListBloc extends Bloc<TimeRangeListEvent, TimeRangeListState> {
  TimeRangeListBloc({
    required this.context,
  }) : super(const TimeRangeListState()) {
    on<TimeRangeAddEvent>(_onTimeRangeAddEvent);
    on<TimeRangeRemoved>(_onTimeRangeRemoved);
  }

  final BuildContext context;

  FutureOr<void> _onTimeRangeAddEvent(TimeRangeAddEvent event, Emitter<TimeRangeListState> emit) async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  FutureOr<void> _onTimeRangeRemoved(TimeRangeRemoved event, Emitter<TimeRangeListState> emit) {

  }
}
