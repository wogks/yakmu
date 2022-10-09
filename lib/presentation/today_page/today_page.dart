import 'dart:io';

import 'package:alyak/domain/model/medicine_alarm_model.dart';
import 'package:alyak/domain/model/medicine_history_model.dart';
import 'package:alyak/domain/model/medicine_model.dart';
import 'package:alyak/main.dart';
import 'package:alyak/presentation/add_medicine_page/components/add_medicine_page_component.dart';
import 'package:alyak/presentation/components/%08time_setting_bottomsheet.dart';
import 'package:alyak/presentation/today_page/components/emty_widget.dart';
import 'package:alyak/util/dory_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../add_alarm_page/add_alarm_page_view_model.dart';
import 'components/today_take_tile.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '오늘 복용할 약은?',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: regularSpace),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: medicineRepository.medicineBox.listenable(),
            builder: _buildMedicineListView,
          ),
        ),
      ],
    );
  }

  Widget _buildMedicineListView(context, Box<MeidicineModel> box, _) {
    final medicines = box.values.toList();
    final medicineAlarms = <MedicineAlarm>[];
    //리스트가 비어있을떄 빈화면을 보여주는 창
    if (medicines.isEmpty) {
      return const TodayEmpty();
    }

    for (var medicine in medicines) {
      for (var alarm in medicine.alarms) {
        medicineAlarms.add(MedicineAlarm(
          medicine.id,
          medicine.name,
          medicine.imagePath,
          alarm,
          medicine.key,
        ));
      }
    }

    return Column(
      children: [
        const Divider(height: 1, thickness: 1.0), //리스트부에서 짝 끊어줌
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: smallSpace),
            itemCount: medicineAlarms.length,
            itemBuilder: (context, index) {
              return AfterTakeTile(
                medicineAlarm: medicineAlarms[index],
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: regularSpace,
              );
            },
          ),
        ),
        const Divider(height: 1, thickness: 1.0), //리스트부에서 짝 끊어줌
      ],
    );
  }
}





class TileActionButton extends StatelessWidget {
  const TileActionButton({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    final buttonTextStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(fontWeight: FontWeight.w500);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title, style: buttonTextStyle),
      ),
    );
  }
}
