import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class Smile extends StatefulWidget {
  final bool isNice;

  Smile({this.isNice});

  @override
  State<StatefulWidget> createState() {
    return _SmileState();
  }
}

class _SmileState extends State<Smile> {
  bool isNice;

  @override
  void initState() {
    super.initState();

    isNice = widget.isNice;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          isNice = !isNice;
        });
      },
      child: CustomPaint(
          painter: _SmilePainter(isNice: isNice), size: Size(300, 300)),
    );
  }
}

class _SmilePainter extends CustomPainter {
  final bool isNice;
  bool repaint = false;

  _SmilePainter({this.isNice});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = math.min(size.height, size.width) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final paintNice = Paint()
      ..color = AppColors.dodgerBlue
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0;

    final paintNotNice = Paint()
      ..color = AppColors.amaranth
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0;

    final paint2 = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0;

    final smilePaint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawCircle(center, radius, (isNice ? paintNice : paintNotNice));
    canvas.drawCircle(
        Offset(center.dx + radius / 3, center.dy - radius / 3), 20.0, paint2);
    canvas.drawCircle(
        Offset(center.dx - radius / 3, center.dy - radius / 3), 20.0, paint2);
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(
                center.dx, center.dy + (isNice ? radius / 4 : radius / 2)),
            radius: radius / 3),
        isNice ? math.pi / 6 : 7 * math.pi / 6,
        2 * math.pi / 3,
        false,
        smilePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return (isNice != (oldDelegate as _SmilePainter).isNice);
  }
}
