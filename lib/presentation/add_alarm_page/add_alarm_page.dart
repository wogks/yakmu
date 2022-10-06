import 'dart:io';

import 'package:alyak/util/dory_constants.dart';
import 'package:flutter/material.dart';

import '../../util/add_page_widget.dart';

class AddAlarmPage extends StatelessWidget {
  const AddAlarmPage({
    super.key,
    required this.medicineImage,
    required this.medicineName,
  });

  final File? medicineImage;
  final String medicineName;

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
          const Text('불로장생, 무병장수하시오.',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: largeSpace),
          Expanded(child: ListView(),),
        ],
      ),
    );
  }
}
