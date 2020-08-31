import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/constants/timer.constant.dart';

class SetTimerWidget extends StatefulWidget {
  final int focusTime, restTime;
  final Function(int focusValue, int restValue) playTimerCallback;

  SetTimerWidget({
    this.focusTime,
    this.restTime,
    @required this.playTimerCallback
  });

  @override
  _SetTimerWidgetState createState() => _SetTimerWidgetState();
}

class _SetTimerWidgetState extends State<SetTimerWidget> {
  bool _isFocus = true;
  double _currentValue;
  int _focusValue, _restValue;

  @override
  void initState() {
    super.initState();

    _focusValue = widget.focusTime ?? 5;
    _restValue = widget.restTime ?? 5;
    _currentValue = _isFocus? _focusValue.toDouble() : _restValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_isFocus? TimerConstant.TIMER_TITLE_FOCUS : TimerConstant.TIMER_TITLE_REST),

        Slider(
          divisions: 9,
          value: _currentValue,
          min: 5,
          max: 50,
          label: '${_currentValue.round().toString()} min',
          onChanged: (double value) {
            setState(() {
              _currentValue = value;

              if(_isFocus) {
                _focusValue = value.round();
              } else {
                _restValue = value.round();
              }
            });
          },
        ),

        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () {
            widget.playTimerCallback(_focusValue, _restValue);
          },
        ),

        RaisedButton(
          child: Text('Change Time Interval'),
          onPressed: () {
            setState(() {
              _isFocus = !_isFocus;
              _currentValue = _isFocus? _focusValue.toDouble() : _restValue.toDouble();
            });
          },
        )
      ],
    );
  }
}
