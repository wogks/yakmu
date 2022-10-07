import 'dart:io';

import 'package:alyak/presentation/add_alarm_page/add_alarm_page_view_model.dart';
import 'package:alyak/util/dory_constants.dart';
import 'package:alyak/util/dory_notofication.dart';
import 'package:alyak/util/dory_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../util/add_page_widget.dart';

class AddAlarmPage extends StatelessWidget {
  AddAlarmPage({
    super.key,
    required this.medicineImage,
    required this.medicineName,
  });

  final File? medicineImage;
  final String medicineName;

  final _viewModel = AddAlarmViewModel();

  @override
  Widget build(BuildContext context) {
    final doryNotificationServiceViewModel =
        context.watch<DoryNotificationService>();
    return Scaffold(
      appBar: AppBar(),
      body: AddPageBody(
        children: [
          Text(
            '매일 잊지말고 복약!',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: smallSpace),
          const Text(
            '불로장생, 무병장수하시오.',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: largeSpace),
          Expanded(
            child: AnimatedBuilder(
              builder: (context, _) {
                return ListView(children: alarmWidgets);
              },
              animation: _viewModel,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: submitButtonBoxPadding,
          child: SizedBox(
            height: submitButtonHeight,
            child: ElevatedButton(
              onPressed: () async {
                bool result = false;
                //1. add alarm
                for (var alarm in _viewModel.alarms) {
                     result = await doryNotificationServiceViewModel.addNotifcication(
                    alarmTimeStr: alarm,
                    title: '$alarm 약먹을 시간이네!',
                    body: '$medicineName 먹는거 잊지말기',
                  );
                  if (!result) {
                    // ignore: use_build_context_synchronously
                    showPermissionDenied(context, permission: '알람');
                  }
                 
                }

                //2. save image (local dir)
                //3. add medicine model (local db, hive)
              },
              style: ElevatedButton.styleFrom(
                textStyle: Theme.of(context).textTheme.subtitle1,
              ),
              child: const Text('완료'),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> get alarmWidgets {
    final children = <Widget>[];

    children.addAll(
      _viewModel.alarms.map(
        (alarmTime) => AlarmBox(
          time: alarmTime,
          viewModel: _viewModel,
        ),
      ),
    );
    children.add(AddAlarmButton(
      viewModel: _viewModel,
    ));
    return children;
  }
}

class AlarmBox extends StatelessWidget {
  const AlarmBox({
    Key? key,
    required this.time,
    required this.viewModel,
  }) : super(key: key);

  final String time;
  final AddAlarmViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: () {
              viewModel.removeAlarm(time);
            },
            icon: const Icon(CupertinoIcons.minus_circle),
          ),
        ),
        Expanded(
          flex: 5,
          child: TextButton(
            style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.subtitle2),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return TimePickerBottomSheet(
                    viewModel: viewModel,
                    initialTime: time,
                  );
                },
              );
            },
            child: Text(time),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class TimePickerBottomSheet extends StatelessWidget {
  TimePickerBottomSheet({
    Key? key,
    required this.initialTime,
    required this.viewModel,
  }) : super(key: key);

  final String initialTime;
  final AddAlarmViewModel viewModel;
  DateTime? _setDateTime;
  //time값을 datetime값으로 변환해야함

  @override
  Widget build(BuildContext context) {
    final initialDateTime = DateFormat('HH:mm').parse(initialTime);
    return BottomSheetBody(
      children: [
        SizedBox(
          height: 300,
          child: CupertinoDatePicker(
            onDateTimeChanged: (dateTime) {
              _setDateTime = dateTime;
            },
            mode: CupertinoDatePickerMode.time,
            //초기 시간 설정
            initialDateTime: initialDateTime,
          ),
        ),
        const SizedBox(
          height: regularSpace,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: submitButtonHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.subtitle1),
                  onPressed: () {
                    viewModel.setAlarm(
                      prevTime: initialTime,
                      setTime: _setDateTime ?? initialDateTime,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('선택'),
                ),
              ),
            ),
            const SizedBox(width: smallSpace),
            Expanded(
              child: SizedBox(
                height: submitButtonHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.subtitle1,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('취소'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AddAlarmButton extends StatelessWidget {
  const AddAlarmButton({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final AddAlarmViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.subtitle2,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      ),
      onPressed: viewModel.addNowAlarm,
      child: Row(
        children: const [
          Expanded(flex: 1, child: Icon(CupertinoIcons.plus_circle_fill)),
          Expanded(
            flex: 5,
            child: Center(child: Text('복용시간 추가')),
          ),
        ],
      ),
    );
  }
}
