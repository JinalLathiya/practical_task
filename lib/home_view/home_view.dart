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
                  onPressed: () => context.read<TimeRangeListBloc>().add(
                        TimeRangeAddEvent(
                          day: days,
                          timeData: TimeData(
                            fromTime: TimeOfDay.now(),
                            toTime: TimeOfDay.now(),
                          ),
                        ),
                      ),
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
                children: [
                  ...state.map(
                    (e) {
                      if (state.isEmpty) return const SizedBox.shrink();
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(RadiusValues.normal),
                        ),
                        padding: const EdgeInsetsDirectional.only(start: Spacing.small),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${e.fromTime?.hour}:${e.fromTime?.minute}-${e.toTime?.hour}:${e.toTime?.minute}",
                              style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                            ),
                            const Gap(4),
                            const Icon(Icons.close, color: Colors.white, size: 20),
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
