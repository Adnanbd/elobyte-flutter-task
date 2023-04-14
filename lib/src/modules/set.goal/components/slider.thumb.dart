import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class SliderThumbImage extends SliderComponentShape {
  final ui.Image image;

  SliderThumbImage(this.image);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(0, 0);
  }

  @override
  void paint(
    PaintingContext context,
    ui.Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required ui.TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required ui.Size sizeWithOverflow,
  }) {
    // TODO: implement paint
    final canvas = context.canvas;
    final imageWidth = image.width;
    final imageHeight = image.height;
    Offset imageOffset = Offset(
      center.dx - (imageWidth / 2),
      center.dy - (imageHeight / 2),
    );
    Paint paint = Paint()..filterQuality = FilterQuality.high;
    canvas.drawImage(image, imageOffset, paint);
  }
}
