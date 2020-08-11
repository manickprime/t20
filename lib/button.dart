import 'package:flutter/material.dart';
import 'package:t20/progresspainter.dart';

class CircleButton extends StatefulWidget {
  @override
  _CircleButtonState createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(225, 234, 244, 1),
            boxShadow: [
              BoxShadow(
                offset: Offset(-5, -5),
                color: Colors.white,
              ),
              BoxShadow(
                  offset: Offset(10.5, 10.5),
                  color: Color.fromRGBO(225, 234, 244, 1)),
            ],
            border: Border.all(width: 15, color: Colors.white)),
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: 250,
                child: CustomPaint(
                  painter: ProgressPainter(
                    circleWidth: 60,
                    completedPercentage: 60,
                    defaultCircleColor: Colors.red,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.0),
                      Colors.black54,
                    ],
                    stops: [0.95, 1.0],
                  ),
                  border: Border.all(
                    width: 15,
                    color: Colors.white,
                  ),
                ),
                child: Center(child: NeuStartButton()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NeuStartButton extends StatefulWidget {
  final double bevel;
  final Offset blurOffset;

  NeuStartButton({
    Key key,
    this.bevel = 10.0,
  })  : this.blurOffset = Offset(bevel / 2, bevel / 2),
        super(key: key);

  @override
  _NeuStartButtonState createState() => _NeuStartButtonState();
}

class _NeuStartButtonState extends State<NeuStartButton> {
  bool _isPressed = false;
  bool _isRunning = false;

//  void _onPointerDown() {
//    setState(() {
//      _isPressed = true;
//    });
//  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
//      onPointerDown: (_) {
//        _onPointerDown();
//        _isRunning
//            ? Provider.of<TimerService>(context, listen: false).stop()
//            : Provider.of<TimerService>(context, listen: false).start();
//        setState(() => _isRunning = !_isRunning);
//      },
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 95,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white70,
          boxShadow: _isPressed
              ? null
              : [
                  BoxShadow(
                    blurRadius: 15,
                    spreadRadius: 5,
                    offset: -widget.blurOffset,
                    color: Colors.white,
                  ),
                  BoxShadow(
                    blurRadius: 15,
                    offset: Offset(10.5, 10.5),
                    color: Color.fromRGBO(214, 223, 230, 1),
                  )
                ],
        ),
        child: Center(
            child: Icon(
          _isRunning ? Icons.stop : Icons.play_arrow,
          size: 60,
          color: _isRunning
              ? Colors.redAccent.shade400
              : Colors.greenAccent.shade400,
        )),
      ),
    );
  }
}

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
}
