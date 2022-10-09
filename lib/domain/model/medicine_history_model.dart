import 'package:hive/hive.dart';

part 'medicine_history_model.g.dart';

@HiveType(typeId: 2)
class MedicineHistory extends HiveObject {
  MedicineHistory({
    required this.medicineId,
    required this.alarmTime,
    required this.takeTime,
  });

  //id(식별할 아이디), name, image(optional), alarms
  @HiveField(0)
  final int medicineId; //unique id,

  @HiveField(1)
  final String alarmTime;

  @HiveField(2)
  final DateTime takeTime;

  @override
  String toString() {
    return 'medicineId:$medicineId, alarmTime: $alarmTime, takeTime: $takeTime';
  }
}
