import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAlarmViewModel with ChangeNotifier {
  final _alarms = <String>{
    '8:00',
    '13:00',
    '19:00',
  };

  Set<String> get alarms => _alarms;

  void addNowAlarm() {
    final now = DateTime.now();
    //intl add dependency 해야함 시간 출력 포맷 변경
    final nowTime = DateFormat('HH:mm').format(now);

    _alarms.add(nowTime);
    notifyListeners();
  }

  void removeAlarm(String alarmTime) {
    _alarms.remove(alarmTime);
    notifyListeners();
  }

  void setAlarm({required String prevTime, required DateTime setTime}) {
    _alarms.remove(prevTime);

    final setTimeStr = DateFormat('HH:mm').format(setTime);
    _alarms.add(setTimeStr);
    notifyListeners();
  }
}
