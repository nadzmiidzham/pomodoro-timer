import 'package:pomodoro_timer/core/models/timer.model.dart';
import 'package:pomodoro_timer/core/services/timer.service..dart';
import 'package:pomodoro_timer/locator.dart';
import 'package:pomodoro_timer/ui/viewmodels/base.viewmodel.dart';

class TimerViewModel extends BaseViewModel {
  TimerService _timerService = locator<TimerService>();
  TimerModel timer = TimerModel(focus: 25, rest: 5);
  bool isActive = false;

  // getter
  int get focusTime {
    return timer.focus;
  }

  int get restTime {
    return timer.rest;
  }

  // init
  initTimeSetting() async {
    setState(ViewState.BUSY);
    timer =
        await _timerService.getTimerSetting() ?? TimerModel(focus: 25, rest: 5);
    setState(ViewState.IDLE);
  }

  // action methods
  changeMode() {
    setState(ViewState.BUSY);
    isActive = !isActive;
    setState(ViewState.IDLE);
  }

  saveTimerSetting(int focusDuration, int restDuration) async {
    setState(ViewState.BUSY);
    if (await _timerService.saveTimerSetting(focusDuration, restDuration)) {
      timer = await _timerService.getTimerSetting() ??
          TimerModel(focus: 25, rest: 5);
    }
    setState(ViewState.IDLE);
  }
}
