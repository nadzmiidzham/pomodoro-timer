import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pomodoro_timer/core/constants/timer.constant.dart';

class TimerWidget extends StatefulWidget {
  final Duration focusDuration, restDuration;
  final Color focusColor, restColor;
  final VoidCallback stopTimerCallback;

  TimerWidget({
    @required this.focusDuration,
    @required this.restDuration,
    @required this.focusColor,
    @required this.restColor,
    this.stopTimerCallback,
  });

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> with TickerProviderStateMixin {
  AnimationController controller;
  bool isFocus = true;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: isFocus? widget.focusDuration : widget.restDuration)
      ..addListener(() {
        if(controller.value <= 0) {
          _changeTimeInterval();
        }
      });

    _playTimer();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          // timer arc
          Positioned.fill(child: _timerArcWidget()),

          // timer countdown
          Align(
            alignment: FractionalOffset.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _timerTitleWidget(isFocus? TimerConstant.TIMER_TITLE_FOCUS : TimerConstant.TIMER_TITLE_REST),
                _timerCountDownWidget()
              ],
            ),
          ),

          // timer action button
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: _actionButtonWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timerTitleWidget(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, color: Colors.black)
    );
  }

  Widget _timerCountDownWidget() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        Duration duration = controller.duration * controller.value;

        return Text(
          '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
          style: TextStyle(
            fontSize: 110,
            color: Colors.black,
          ),
        );
      },
    );
  }

  Widget _timerArcWidget() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: TimerPainter(
            animation: controller,
            backgroundColor: Colors.black,
            color: isFocus? widget.focusColor : widget.restColor
          ),
        );
      },
    );
  }

  Widget _actionButtonWidget() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        if(!controller.isAnimating) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // play button
              FloatingActionButton(
                child: Icon(Icons.play_arrow),
                onPressed: () {
                  _playTimer();
                },
              ),

              // stop button
              FloatingActionButton(
                child: Icon(Icons.stop),
                onPressed: () {
                  _stopTimer();
                },
              )
            ],
          );
        }

        // pause button
        return FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () {
            _pauseTimer();
          },
        );
      },
    );
  }

  void _playTimer() {
    controller.reverse(from: (controller.value == 0)? 1 : controller.value);
  }

  void _pauseTimer() {
    setState(() => controller.stop());
  }

  void _stopTimer() {
    widget.stopTimerCallback();
  }

  void _changeTimeInterval() {
    setState(() {
      isFocus = !isFocus;
      controller.duration = isFocus? widget.focusDuration : widget.restDuration;
    });

    _playTimer();
  }
}

class TimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor, color;

  TimerPainter({
    @required this.animation,
    @required this.backgroundColor,
    @required this.color
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = pi * 0.6;
    double sweepAngle = pi * 1.8;
    double progress = animation.value * sweepAngle;
    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    Paint foregroundPaint = Paint()
      ..color = color
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(Offset.zero & size, startAngle, sweepAngle, false, backgroundPaint);
    canvas.drawArc(Offset.zero & size, startAngle, progress, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return old.animation.value != animation.value
        || old.backgroundColor != backgroundColor
        || old.color != color;
  }
}
