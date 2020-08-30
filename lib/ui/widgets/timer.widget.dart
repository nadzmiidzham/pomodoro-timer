import 'dart:math';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final String title;
  final Duration timerDuration;
  final VoidCallback timerFinishedCallback;

  TimerWidget({
    @required this.title,
    @required this.timerDuration,
    this.timerFinishedCallback
  });

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: widget.timerDuration)
      ..addStatusListener((status) {
        if(status == AnimationStatus.completed) {
          widget.timerFinishedCallback();
        }
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          // timer arc
          Positioned.fill(child: _timerArc()),

          // timer countdown
          Align(
            alignment: FractionalOffset.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _timerTitle(widget.title),
                _timerCountDown(widget.timerDuration)
              ],
            ),
          ),

          // timer action button
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: _actionButton(),
          ),
        ],
      ),
    );
  }

  Widget _timerTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, color: Colors.black)
    );
  }

  Widget _timerCountDown(Duration duration) {
    Duration duration = controller.duration * controller.value;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Text(
          '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
          style: TextStyle(
            fontSize: 110,
            color: Colors.black
          ),
        );
      },
    );
  }

  Widget _timerArc() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: TimerPainter(
            animation: controller,
            backgroundColor: Colors.black,
            color: Colors.green
          ),
        );
      },
    );
  }

  Widget _actionButton() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return FloatingActionButton(
          child: Icon((controller.isAnimating)? Icons.pause : Icons.play_arrow),
          onPressed: () {
            controller.reverse(from: (controller.value == 0)? 1 : controller.value);
          },
        );
      },
    );
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
    double progress = (1 - animation.value) * sweepAngle;
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