import 'package:practical_task/home_view/time_range_list/time_range_list.dart';

sealed class TimeRangeListEvent {
  const TimeRangeListEvent();
}

class TimeRangeAddEvent extends TimeRangeListEvent {
  const TimeRangeAddEvent({
    required this.day,
    required this.timeData,
  });

  final Days day;
  final TimeData timeData;
}

class TimeRangeRemoved extends TimeRangeListEvent {
  const TimeRangeRemoved({
    required this.day,
    required this.index,
  });

  final Days day;
  final int index;
}
