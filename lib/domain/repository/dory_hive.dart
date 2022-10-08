import 'package:alyak/domain/model/medicine_model.dart';
import 'package:hive_flutter/hive_flutter.dart';



class DoryHive {
  Future<void> initializeHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter<MeidicineModel>(MeidicineModelAdapter());

    await Hive.openBox<MeidicineModel>(DoryHiveBox.medicine);
  }
}

class DoryHiveBox {
  static const String medicine = 'medicine';
}