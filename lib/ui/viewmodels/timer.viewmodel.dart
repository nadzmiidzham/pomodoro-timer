import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pomodoro_timer/core/models/timer.model.dart';
import 'package:pomodoro_timer/core/services/timer.service..dart';

class TimerViewModel extends ChangeNotifier {
  TimerService _timerService = GetIt.instance<TimerService>();
  bool isActive = true;
  TimerModel timer = TimerModel(focus: 25, rest: 5);

  constructor() async {
    timer = await _timerService.getTimerSetting() ?? TimerModel(focus: 25, rest: 5);
  }

  // getter
  int get focusTime { return timer.focus; }
  int get restTime { return timer.rest; }

  // action methods
  changeMode() async {
    isActive = !isActive;
    notifyListeners();
  }

  saveTimerSetting(int focusDuration, int restDuration) async {
    if(await _timerService.saveTimerSetting(focusDuration, restDuration)) {
      timer = await _timerService.getTimerSetting() ?? TimerModel(focus: 25, rest: 5);
    }
    notifyListeners();
  }
}
