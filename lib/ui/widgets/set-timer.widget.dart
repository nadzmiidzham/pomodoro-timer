import 'package:flutter/material.dart';

class SetTimerWidget extends StatefulWidget {
  final double minValue, maxValue;
  final Function(int, int) playTimerCallback;

  SetTimerWidget({
    this.minValue,
    @required this.maxValue,
    @required this.playTimerCallback
  });

  @override
  _SetTimerWidgetState createState() => _SetTimerWidgetState();
}

class _SetTimerWidgetState extends State<SetTimerWidget> {
  bool _isFocus = true;
  int _division;
  int _focusValue = 0, _restValue = 0;
  double _currentValue = 0;

  @override
  void initState() {
    super.initState();

    _division = (widget.maxValue / 5).round();
    _currentValue = widget.minValue ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_isFocus? 'FOCUS' : 'REST'),

        Slider(
          divisions: _division,
          value: _currentValue,
          min: 0,
          max: widget.maxValue,
          label: _currentValue.round().toString(),
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
