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
    switch (event.day) {
      case Days.monday:
        final List<TimeData> mondayList = List.from(state.mondayTimeData);
        mondayList.addAll([TimeData(startTime: event.timeData.startTime, endTime: event.timeData.endTime)]);
        emit(state.copyWith(mondayTimeData: mondayList));

      case Days.tuesday:
        final List<TimeData> tuesdayList = List.from(state.tuesdayTimeData);
        tuesdayList.addAll([TimeData(startTime: event.timeData.startTime, endTime: event.timeData.endTime)]);
        emit(state.copyWith(tuesdayTimeData: tuesdayList));

      case Days.wednesday:
        final List<TimeData> wednesdayList = List.from(state.wednesdayTimeData);
        wednesdayList.addAll([TimeData(startTime: event.timeData.startTime, endTime: event.timeData.endTime)]);
        emit(state.copyWith(wednesdayTimeData: wednesdayList));

      case Days.thursday:
        final List<TimeData> thursdayList = List.from(state.thursdayTimeData);
        thursdayList.addAll([TimeData(startTime: event.timeData.startTime, endTime: event.timeData.endTime)]);
        emit(state.copyWith(thursdayTimeData: thursdayList));

      case Days.friday:
        final List<TimeData> fridayList = List.from(state.fridayTimeData);
        fridayList.addAll([TimeData(startTime: event.timeData.startTime, endTime: event.timeData.endTime)]);
        emit(state.copyWith(fridayTimeData: fridayList));

      case Days.saturday:
        final List<TimeData> saturdayList = List.from(state.saturdayTimeData);
        saturdayList.addAll([TimeData(startTime: event.timeData.startTime, endTime: event.timeData.endTime)]);
        emit(state.copyWith(saturdayTimeData: saturdayList));

      case Days.sunday:
        final List<TimeData> sundayList = List.from(state.sundayTimeData);
        sundayList.addAll([TimeData(startTime: event.timeData.startTime, endTime: event.timeData.endTime)]);
        emit(state.copyWith(sundayTimeData: sundayList));
    }
  }

  FutureOr<void> _onTimeRangeRemoved(TimeRangeRemoved event, Emitter<TimeRangeListState> emit) {
    switch (event.day) {
      case Days.monday:
        final List<TimeData> mondayTimeList = [...state.mondayTimeData]..removeAt(event.index);
        emit(state.copyWith(mondayTimeData: mondayTimeList));

      case Days.tuesday:
        final List<TimeData> tuesdayTimeList = [...state.tuesdayTimeData]..removeAt(event.index);
        emit(state.copyWith(tuesdayTimeData: tuesdayTimeList));

      case Days.wednesday:
        final List<TimeData> wednesdayTimeList = [...state.wednesdayTimeData]..removeAt(event.index);
        emit(state.copyWith(wednesdayTimeData: wednesdayTimeList));

      case Days.thursday:
        final List<TimeData> thursdayTimeList = [...state.thursdayTimeData]..removeAt(event.index);
        emit(state.copyWith(thursdayTimeData: thursdayTimeList));

      case Days.friday:
        final List<TimeData> fridayTimeList = [...state.fridayTimeData]..removeAt(event.index);
        emit(state.copyWith(fridayTimeData: fridayTimeList));

      case Days.saturday:
        final List<TimeData> saturdayTimeList = [...state.saturdayTimeData]..removeAt(event.index);
        emit(state.copyWith(saturdayTimeData: saturdayTimeList));

      case Days.sunday:
        final List<TimeData> sundayTimeList = [...state.sundayTimeData]..removeAt(event.index);
        emit(state.copyWith(sundayTimeData: sundayTimeList));
    }
  }
}
