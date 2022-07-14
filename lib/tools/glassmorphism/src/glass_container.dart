import 'dart:ui';

import 'package:flutter/material.dart';

/// Widget that blur it's child
class Blur extends StatelessWidget {
  /// Widget that blur it's child
  const Blur({key,  this.blur,  this.child});

  ///Blur intensity
  final double blur;

  ///[Widget] child to be blurred.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (blur < 1) return child;

    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: child,
    );
  }
}

///Widget Blur Extensions
extension BlurWidgetExt on Widget {
  ///Blur the widget
  Widget blur({ double blur}) {
    return Blur(blur: blur, child: this);
  }

  ///[Blur] widget with [ClipRect] parent
  Widget blurClipped({ double blur}) {
    return ClipRect(child: Blur(blur: blur, child: this));
  }
}
