import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: CircleArea(
            isTop: true,add 
          )),
          Expanded(
              child: CircleArea(
            isTop: false,
          )),
        ],
      ),
    );
  }
}

class CircleArea extends StatefulWidget {
  final bool isTop;

  CircleArea({required this.isTop});

  @override
  _CircleAreaState createState() => _CircleAreaState();
}

class _CircleAreaState extends State<CircleArea> {
  Offset? circlePosition;

  @override
  void initState() {
    super.initState();
    // 這裡需要稍後在build方法中設置，因為我們需要使用size
    circlePosition = null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (circlePosition == null) {
      if (widget.isTop) {
        circlePosition = Offset(size.width / 2, size.height / 8);
      } else {
        circlePosition = Offset(size.width / 2, size.height / 5 * 2);
      }
    }

    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          circlePosition = details.localPosition;
        });
      },
      child: CustomPaint(
        painter: CirclePainter(circlePosition),
        child: Container(),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Offset? position;

  CirclePainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    if (position != null) {
      final adjustedPosition = Offset(
        position!.dx.clamp(25, size.width - 25),
        position!.dy.clamp(25, size.height - 25),
      );
      canvas.drawCircle(adjustedPosition, 25, paint); // 更改半徑為25
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
