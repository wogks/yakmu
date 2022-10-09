import 'dart:io';

import 'package:flutter/material.dart';

import '../../../domain/model/medicine_alarm_model.dart';

class ImageDetailPage extends StatelessWidget {
  const ImageDetailPage({
    Key? key,
    required this.medicineAlarm,
  }) : super(key: key);

  final MedicineAlarm medicineAlarm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
      ),
      body: Center(
        child: Image.file(File(medicineAlarm.imagePath!)),
      ),
    );
  }
}