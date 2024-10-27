import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:practical_task/Models/post_data.dart';
import 'package:practical_task/components/components.dart';
import 'package:practical_task/home_view/api_call/api_call.dart';
import 'package:practical_task/home_view/time_range_list/time_range_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TimeRangeListBloc(context: context)),
        BlocProvider(create: (context) => ApiCallBloc(context: context)),
      ],
      child: BlocListener<ApiCallBloc, ApiCallState>(
        listener: (context, state) async {
          if (state is ApiCallSuccessState) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => _ResponseDialog(data: state.postData),
            );
          }
        },
        child: const _HomeView(),
      ),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(Spacing.normal, Spacing.none, Spacing.normal, Spacing.normal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(Spacing.normal),
              const _IntroContent(),
              const Gap(Spacing.normal),
              const _ListContent(),
              const Gap(Spacing.normal),
              ElevatedButton(
                onPressed: () => context.read<ApiCallBloc>().add(const ApiCallRequested()),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IntroContent extends StatelessWidget {
  const _IntroContent();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 60,
            child: Container(
              height: 100,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: ShapeBorderRadius.medium,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 8,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsetsDirectional.only(bottom: Spacing.small),
                child: Text(
                  'Rushabh Dev',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: const NetworkImage(
                "https://images.pexels.com/photos/5103723/pexels-photo-5103723.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load"),
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                clipBehavior: Clip.none,
                padding: const EdgeInsets.symmetric(horizontal: Spacing.small),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(RadiusValues.normal),
                  color: Colors.white,
                ),
                child: const Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                        child: Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 17,
                        ),
                      ),
                      TextSpan(text: '5', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ListContent extends StatelessWidget {
  const _ListContent();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Days.values.length,
      itemBuilder: (context, index) {
        final days = Days.values[index];
        return Container(
        padding: const EdgeInsets.symmetric(vertical: Spacing.small, horizontal: Spacing.normal),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(RadiusValues.medium),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(child: Text(days.getLabel(context), style: textTheme.bodyLarge)),
                ElevatedButton.icon(
                    onPressed: () async {
                      final bloc = context.read<TimeRangeListBloc>();
                      await showDialog(
                        context: context,
                        builder: (context) => BlocProvider.value(
                          value: bloc,
                          child: _SelectTimeRangeDialog(days: days),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add'),
                  ),
                ],
              ),
              BlocSelector<TimeRangeListBloc, TimeRangeListState, List<TimeData>>(
                selector: (state) {
                  return switch (days) {
                    Days.monday => state.mondayTimeData,
                    Days.tuesday => state.tuesdayTimeData,
                    Days.wednesday => state.wednesdayTimeData,
                  Days.thursday => state.thursdayTimeData,
                  Days.friday => state.fridayTimeData,
                  Days.saturday => state.saturdayTimeData,
                  Days.sunday => state.sundayTimeData,
                };
              },
                builder: (context, state) => Wrap(
                  spacing: Spacing.normal,
                  children: [
                    ...state.map(
                      (e) {
                        if (state.isEmpty) return const SizedBox.shrink();
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(RadiusValues.normal),
                          ),
                          padding: const EdgeInsetsDirectional.all(Spacing.small),
                          margin: const EdgeInsetsDirectional.only(top: Spacing.small),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${e.startTime?.format(context)} - ${e.endTime?.format(context)}",
                                style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                              ),
                              const Gap(4),
                              InkWell(
                                onTap: () {
                                  final index = state.indexWhere((element) => element == e);
                                  if (!index.isNegative) {
                                    context.read<TimeRangeListBloc>().add(
                                          TimeRangeRemoved(
                                            day: days,
                                            index: index,
                                          ),
                                        );
                                  }
                                },
                                child: const Icon(Icons.close, color: Colors.white, size: 20),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const Gap(Spacing.normal),
    );
  }
}

class _SelectTimeRangeDialog extends StatefulWidget {
  final Days days;

  const _SelectTimeRangeDialog({required this.days});

  @override
  State<_SelectTimeRangeDialog> createState() => _SelectTimeRangeDialogState();
}

class _SelectTimeRangeDialogState extends State<_SelectTimeRangeDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  TimeOfDay? startTime = TimeOfDay.now();
  TimeOfDay? endTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.medium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsetsDirectional.only(start: Spacing.normal),
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(topRight: RadiusValues.medium, topLeft: RadiusValues.medium),
            ),
            child: Row(
              children: [
                Expanded(child: Text("Select Time", style: textTheme.titleLarge)),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.black),
                ),
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(Spacing.normal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TimeInputField(
                    controller: _startTimeController,
                    hintText: "Select From Time",
                    suffixWidget: IconButton(
                      onPressed: () async {
                        TimeOfDay? startTimeResult = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (startTimeResult != null && context.mounted) {
                          _startTimeController.text = startTimeResult.format(context);
                          startTime = startTimeResult;
                        }
                      },
                      icon: const Icon(Icons.calendar_month_rounded),
                    ),
                    validator: (value) {
                      value = value?.trim() ?? '';
                      if (value.isEmpty) return 'Please Select Start Time!';
                      return null;
                    },
                  ),
                  const Gap(Spacing.normal),
                  TimeInputField(
                    controller: _endTimeController,
                    hintText: "Select End Time",
                    suffixWidget: IconButton(
                      onPressed: () async {
                        TimeOfDay? endTimeResult = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (endTimeResult != null && context.mounted) {
                          _endTimeController.text = endTimeResult.format(context);
                          endTime = endTimeResult;
                        }
                      },
                      icon: const Icon(Icons.calendar_month_rounded),
                    ),
                    validator: (value) {
                      int startTimeInMinute = (startTime?.hour)! * 60 + (startTime!.minute);
                      int endTimeInMinute = (endTime?.hour)! * 60 + (endTime!.minute);
                      final compareValue = startTimeInMinute - endTimeInMinute;
                      value = value?.trim() ?? '';
                      if (value.isEmpty) return 'Please Select End Time!';
                      if (!compareValue.isNegative) return 'End time must be after ${startTime?.format(context)}!';
                      return null;
                    },
                  ),
                  const Gap(Spacing.normal),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() != true) return;
                      context.read<TimeRangeListBloc>().add(
                            TimeRangeAddEvent(
                              day: widget.days,
                              timeData: TimeData(
                                startTime: startTime,
                                endTime: endTime,
                              ),
                            ),
                          );
                      if (context.mounted) return Navigator.of(context).pop();
                    },
                    child: const Text("Save"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResponseDialog extends StatelessWidget {
  const _ResponseDialog({required this.data});

  final PostData data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.medium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsetsDirectional.only(start: Spacing.normal),
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(topRight: RadiusValues.medium, topLeft: RadiusValues.medium),
            ),
            child: Row(
              children: [
                Expanded(child: Text("Post Data", style: textTheme.titleLarge)),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.black),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Spacing.normal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title :', style: textTheme.titleLarge),
                const Divider(height: Spacing.normal),
                Text(data.title),
                const Gap(Spacing.large),
                Text('Body :', style: textTheme.titleLarge),
                const Divider(height: Spacing.normal),
                Text(data.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
