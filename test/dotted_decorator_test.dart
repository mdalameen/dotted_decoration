import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses line shape and bottom position by default', () {
    final decoration = DottedDecoration();

    expect(decoration.shape, Shape.line);
    expect(decoration.linePosition, LinePosition.bottom);
    expect(decoration.color, const Color(0xFF9E9E9E));
    expect(decoration.borderRadius, isNull);
    expect(decoration.dash, const <int>[5, 5]);
    expect(decoration.strokeWidth, 1);
    expect(decoration.backgroundColor, isNull);
  });

  test('stores custom configuration', () {
    final decoration = DottedDecoration(
      shape: Shape.box,
      linePosition: LinePosition.left,
      color: const Color(0xFFFF0000),
      borderRadius: BorderRadius.circular(8),
      dash: const <int>[2, 4],
      strokeWidth: 2,
      backgroundColor: const Color(0xFFEEEEEE),
    );

    expect(decoration.shape, Shape.box);
    expect(decoration.linePosition, LinePosition.left);
    expect(decoration.color, const Color(0xFFFF0000));
    expect(decoration.borderRadius, BorderRadius.circular(8));
    expect(decoration.dash, const <int>[2, 4]);
    expect(decoration.strokeWidth, 2);
    expect(decoration.backgroundColor, const Color(0xFFEEEEEE));
  });

  test('createBoxPainter returns a BoxPainter', () {
    final painter = DottedDecoration().createBoxPainter();

    expect(painter, isA<BoxPainter>());
    painter.dispose();
  });

  testWidgets('paints a dotted line by default', (tester) async {
    await _pumpDecoratedBox(tester, DottedDecoration());

    expect(
      find.byType(DecoratedBox),
      paints
        ..path(
          color: const Color(0xFF9E9E9E),
          style: PaintingStyle.stroke,
          strokeWidth: 1,
        ),
    );
  });

  testWidgets('paints a box with custom color and stroke width', (tester) async {
    await _pumpDecoratedBox(
      tester,
      DottedDecoration(
        shape: Shape.box,
        color: Colors.red,
        strokeWidth: 2,
      ),
    );

    expect(
      find.byType(DecoratedBox),
      paints
        ..path(
          color: Colors.red,
          style: PaintingStyle.stroke,
          strokeWidth: 2,
        ),
    );
  });

  testWidgets('paints a circle', (tester) async {
    await _pumpDecoratedBox(
      tester,
      DottedDecoration(shape: Shape.circle, dash: const <int>[1, 4]),
    );

    expect(
      find.byType(DecoratedBox),
      paints
        ..path(
          color: const Color(0xFF9E9E9E),
          style: PaintingStyle.stroke,
          strokeWidth: 1,
        ),
    );
  });

  testWidgets('paints background color behind a dotted box', (tester) async {
    await _pumpDecoratedBox(
      tester,
      DottedDecoration(
        shape: Shape.box,
        backgroundColor: Colors.blue,
      ),
    );

    expect(
      find.byType(DecoratedBox),
      paints
        ..path(
          color: Colors.blue,
          style: PaintingStyle.fill,
        )
        ..path(
          color: const Color(0xFF9E9E9E),
          style: PaintingStyle.stroke,
          strokeWidth: 1,
        ),
    );
  });

  testWidgets('paints background color behind a dotted line', (tester) async {
    await _pumpDecoratedBox(
      tester,
      DottedDecoration(backgroundColor: Colors.yellow),
    );

    expect(
      find.byType(DecoratedBox),
      paints
        ..rect(color: Colors.yellow)
        ..path(
          color: const Color(0xFF9E9E9E),
          style: PaintingStyle.stroke,
          strokeWidth: 1,
        ),
    );
  });

  for (final position in LinePosition.values) {
    testWidgets('paints a $position line', (tester) async {
      await _pumpDecoratedBox(
        tester,
        DottedDecoration(shape: Shape.line, linePosition: position),
      );

      expect(
        find.byType(DecoratedBox),
        paints..path(style: PaintingStyle.stroke),
      );
    });
  }
}

Future<void> _pumpDecoratedBox(
  WidgetTester tester,
  DottedDecoration decoration,
) {
  return tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: SizedBox(
          width: 100,
          height: 80,
          child: DecoratedBox(decoration: decoration),
        ),
      ),
    ),
  );
}
