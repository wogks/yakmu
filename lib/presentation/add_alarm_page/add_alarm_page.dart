import 'dart:io';

import 'package:alyak/util/dory_constants.dart';
import 'package:alyak/util/dory_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../util/add_page_widget.dart';

class AddAlarmPage extends StatefulWidget {
  const AddAlarmPage({
    super.key,
    required this.medicineImage,
    required this.medicineName,
  });

  final File? medicineImage;
  final String medicineName;

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
  final _alarms = <String>{
    '8:00',
    '13:00',
    '19:00',
  };

  @override
  Widget build(BuildContext context) {
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
            child: ListView(children: alarmWidgets),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: submitButtonBoxPadding,
          child: SizedBox(
            height: submitButtonHeight,
            child: ElevatedButton(
              onPressed: () {},
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
      _alarms.map(
        (alarmTime) => AlarmBox(
          time: alarmTime,
          onPressedMinus: () {
            setState(() {
              _alarms.remove(alarmTime);
            });
          },
        ),
      ),
    );
    children.add(AddAlarmButton(
      onPressedPlus: () {
        setState(() {
          final now = DateTime.now();
          //intl add dependency 해야함 시간 출력 포맷 변경
          final nowTime = DateFormat('HH:mm').format(now);
          _alarms.add(nowTime);
        });
      },
    ));
    return children;
  }
}

class AlarmBox extends StatelessWidget {
  const AlarmBox({
    Key? key,
    required this.time,
    required this.onPressedMinus,
  }) : super(key: key);

  final String time;
  final VoidCallback onPressedMinus;

  

  @override
  Widget build(BuildContext context) {
    //time값을 datetime값으로 변환해야함
    final initTime = DateFormat('HH:mm').parse(time);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: onPressedMinus,
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
                    initialDateTime: initTime,
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

class TimePickerBottomSheet extends StatelessWidget {
  const TimePickerBottomSheet({
    Key? key, required this.initialDateTime,
  }) : super(key: key);

  final DateTime initialDateTime;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBody(
      children: [
        SizedBox(
          height: 300,
          child: CupertinoDatePicker(
            onDateTimeChanged: (dateTime) {},
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
                  onPressed: () {},
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
                  onPressed: () {},
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
    Key? key, required this.onPressedPlus,
  }) : super(key: key);

  final VoidCallback onPressedPlus;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.subtitle2,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      ),
      onPressed: onPressedPlus,
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
