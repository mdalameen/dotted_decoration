import 'dart:ui';
import 'package:flutter/material.dart';

class DottedDecoration extends Decoration {
  const DottedDecoration(
      {this.shape = Shape.line,
      this.linePosition = LinePosition.bottom,
      this.color = const Color(0xFF9E9E9E),
      this.backgroundColor = Colors.white,
      this.borderRadius,
      this.dash = const <int>[5, 5],
      this.strokeWidth = 1});

  final LinePosition linePosition;
  final Shape shape;
  final Color color;
  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final List<int> dash;
  final double strokeWidth;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DottedDecoratorPainter(shape, linePosition, color, backgroundColor,
        borderRadius, dash, strokeWidth);
  }
}

class _DottedDecoratorPainter extends BoxPainter {
  _DottedDecoratorPainter(this.shape, this.linePosition, this.color,
      this.backgroundColor, this.borderRadius, this.dash, this.strokeWidth) {
    borderRadius = borderRadius ?? BorderRadius.circular(0);
  }

  LinePosition linePosition;
  Shape shape;
  Color color;
  Color backgroundColor;
  BorderRadius? borderRadius;
  List<int> dash;
  double strokeWidth;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Path outPath = Path();
    if (shape == Shape.line) {
      if (linePosition == LinePosition.left) {
        outPath.moveTo(offset.dx, offset.dy);
        outPath.lineTo(offset.dx, offset.dy + configuration.size!.height);
      } else if (linePosition == LinePosition.top) {
        outPath.moveTo(offset.dx, offset.dy);
        outPath.lineTo(offset.dx + configuration.size!.width, offset.dy);
      } else if (linePosition == LinePosition.right) {
        outPath.moveTo(offset.dx + configuration.size!.width, offset.dy);
        outPath.lineTo(offset.dx + configuration.size!.width,
            offset.dy + configuration.size!.height);
      } else {
        outPath.moveTo(offset.dx, offset.dy + configuration.size!.height);
        outPath.lineTo(offset.dx + configuration.size!.width,
            offset.dy + configuration.size!.height);
      }
    } else if (shape == Shape.box) {
      final RRect rect = RRect.fromLTRBAndCorners(
        offset.dx,
        offset.dy,
        offset.dx + configuration.size!.width,
        offset.dy + configuration.size!.height,
        bottomLeft: borderRadius!.bottomLeft,
        bottomRight: borderRadius!.bottomRight,
        topLeft: borderRadius!.topLeft,
        topRight: borderRadius!.topRight,
      );
      outPath.addRRect(rect);
    } else if (shape == Shape.circle) {
      outPath.addOval(Rect.fromLTWH(offset.dx, offset.dy,
          configuration.size!.width, configuration.size!.height));
    }

    final PathMetrics metrics = outPath.computeMetrics();
    final Path drawPath = Path();

    for (final PathMetric me in metrics) {
      final double totalLength = me.length;
      int index = -1;

      for (double start = 0; start < totalLength;) {
        double to = start + dash[(++index) % dash.length];
        to = to > totalLength ? totalLength : to;
        final bool isEven = index.isEven;
        if (isEven) drawPath.addPath(me.extractPath(start, to), Offset.zero);
        start = to;
      }
    }

    // Fill background
    canvas.drawPath(
        outPath,
        Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.fill
          ..strokeWidth = strokeWidth);
    // Draw the dotted decoration
    canvas.drawPath(
        drawPath,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth);
  }
}

enum LinePosition { left, top, right, bottom }

enum Shape { line, box, circle }
