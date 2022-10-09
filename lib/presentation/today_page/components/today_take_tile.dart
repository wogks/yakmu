import 'dart:io';

import 'package:alyak/presentation/components/%08time_setting_bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/model/medicine_alarm_model.dart';
import '../../../domain/model/medicine_history_model.dart';
import '../../../main.dart';
import '../../../util/dory_constants.dart';
import '../../add_alarm_page/add_alarm_page_view_model.dart';
import '../../add_medicine_page/components/add_medicine_page_component.dart';

import '../today_page.dart';
import 'image_detail_page.dart';

class BeforeTakeTile extends StatelessWidget {
  const BeforeTakeTile({
    Key? key,
    required this.medicineAlarm,
  }) : super(key: key);

  final MedicineAlarm medicineAlarm;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;
    final viewModel = AddAlarmViewModel();
    return Row(
      children: [
        _MedicineImageButton(medicineAlarm: medicineAlarm),
        const SizedBox(
          width: smallSpace,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildTileBody(textStyle, context, viewModel),
          ),
        ),
        _MoreButton(medicineAlarm: medicineAlarm)
      ],
    );
  }

  

  List<Widget> _buildTileBody(TextStyle? textStyle, BuildContext context, AddAlarmViewModel viewModel) {
    return [
            Text('🕑 ${medicineAlarm.alarmTime}', style: textStyle),
            const SizedBox(height: 6),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(medicineAlarm.name, style: textStyle),
                TileActionButton(
                  onTap: () {},
                  title: '지금',
                ),
                Text('ㅣ', style: textStyle),
                TileActionButton(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => TimeSettingBottomSheet(
                          initialTime: medicineAlarm.alarmTime,
                          viewModel: viewModel),
                    ).then((takeDateTime) {
                      if (takeDateTime == null || takeDateTime is! DateTime) {
                        return;
                      }

                      historyRepository.addHistory(
                        MedicineHistory(
                            medicineId: medicineAlarm.id,
                            alarmTime: medicineAlarm.alarmTime,
                            takeTime: takeDateTime),
                      );
                    });
                  },
                  title: '아까',
                ),
                Text('먹었어요!', style: textStyle),
              ],
            )
          ];
  }
}

class AfterTakeTile extends StatelessWidget {
  const AfterTakeTile({
    Key? key,
    required this.medicineAlarm,
  }) : super(key: key);

  final MedicineAlarm medicineAlarm;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;
    final viewModel = AddAlarmViewModel();
    return Row(
      children: [
        _MedicineImageButton(medicineAlarm: medicineAlarm),
        const SizedBox(
          width: smallSpace,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildTileBody(textStyle, context, viewModel),
          ),
        ),
        _MoreButton(medicineAlarm: medicineAlarm)
      ],
    );
  }

  

  List<Widget> _buildTileBody(TextStyle? textStyle, BuildContext context, AddAlarmViewModel viewModel) {
    return [
      Text.rich(TextSpan(text: '✅ ${medicineAlarm.alarmTime} →',
      style: textStyle,
      children: [
        TextSpan(text: '20:19',style: textStyle?.copyWith(fontWeight: FontWeight.w500))
      ]),
      ),
            const SizedBox(height: 6),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(medicineAlarm.name, style: textStyle),
                TileActionButton(
                  onTap: () {},
                  title: '20:19분에',
                ),
                
                Text('먹었어요!', style: textStyle),
              ],
            )
          ];
  }
}

class _MoreButton extends StatelessWidget {
  const _MoreButton({
    Key? key,
    required this.medicineAlarm,
  }) : super(key: key);

  final MedicineAlarm medicineAlarm;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        medicineRepository.deleteMedicine(medicineAlarm.key);
      },
      child: const Icon(CupertinoIcons.ellipsis_vertical),
    );
  }
}

class _MedicineImageButton extends StatelessWidget {
  const _MedicineImageButton({
    Key? key,
    required this.medicineAlarm,
  }) : super(key: key);

  final MedicineAlarm medicineAlarm;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: medicineAlarm.imagePath == null
          ? null
          : () {
              Navigator.push(
                  context,
                  FadePageRoute(
                      page: ImageDetailPage(medicineAlarm: medicineAlarm)));
            },
      child: CircleAvatar(
        radius: 40,
        foregroundImage: medicineAlarm.imagePath == null
            ? null
            : FileImage(File(medicineAlarm.imagePath!)),
      ),
    );
  }
}