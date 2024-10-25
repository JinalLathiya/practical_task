import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/home_view/time_list/time_list_event.dart';
import 'package:practical_task/home_view/time_list/time_list_state.dart';

final class TimeListBloc extends Bloc<TimeListEvent, TimeListState> {
  TimeListBloc() : super(const TimeListState()) {}
}

final List<String> dayList = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday",
];
