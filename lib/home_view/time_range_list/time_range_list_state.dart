import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TimeRangeListState extends Equatable {
  const TimeRangeListState({
    this.mondayTimeData = const [],
    this.tuesdayTimeData = const [],
    this.wednesdayTimeData = const [],
    this.thursdayTimeData = const [],
    this.fridayTimeData = const [],
    this.saturdayTimeData = const [],
    this.sundayTimeData = const [],
  });

  final List<TimeData> mondayTimeData;
  final List<TimeData> tuesdayTimeData;
  final List<TimeData> wednesdayTimeData;
  final List<TimeData> thursdayTimeData;
  final List<TimeData> fridayTimeData;
  final List<TimeData> saturdayTimeData;
  final List<TimeData> sundayTimeData;

  @override
  List<Object?> get props => [
        mondayTimeData,
        tuesdayTimeData,
        wednesdayTimeData,
        thursdayTimeData,
        fridayTimeData,
        saturdayTimeData,
        sundayTimeData,
      ];
}

class TimeData {
  const TimeData({
    required this.fromTime,
    required this.toTime,
  });

  final TimeOfDay? fromTime;
  final TimeOfDay? toTime;
}

enum Days {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  String getLabel(BuildContext context) {
    return switch (this) {
      Days.monday => "Monday",
      Days.tuesday => "Tuesday",
      Days.wednesday => "Wednesday",
      Days.thursday => "Thursday",
      Days.friday => "Friday",
      Days.saturday => "Saturday",
      Days.sunday => "Sunday",
    };
  }
}
