import 'package:flutter/material.dart';

enum TimerMode {
  ACTIVE,
  INACTIVE
}

class TimerViewModel extends ChangeNotifier {
  TimerMode mode = TimerMode.INACTIVE;

  changeMode() {
    switch(mode) {
      case TimerMode.INACTIVE:
        mode = TimerMode.ACTIVE;
        break;
      case TimerMode.ACTIVE:
        mode = TimerMode.INACTIVE;
        break;
    }

    notifyListeners();
  }
}
