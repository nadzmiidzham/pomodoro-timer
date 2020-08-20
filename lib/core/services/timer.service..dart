import 'dart:convert';

import 'package:pomodoro_timer/core/constants/timer.constant.dart';
import 'package:pomodoro_timer/core/models/timer.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerService {
  saveTimerSetting(int focusDuration, int restDuration) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.setString(TimerConstant.TIMER_SETTING_NAME, jsonEncode(TimerModel(focus: focusDuration, rest: restDuration)));
  }

  getTimerSetting() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String tempJson = preferences.getString(TimerConstant.TIMER_SETTING_NAME);

    return TimerModel.fromJson(jsonDecode(tempJson));
  }
}
