import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class LoginAnimModel {
  Animatable tween;
  double size;
  AnimationProgress animationProgress;
  Random random;

  LoginAnimModel(this.random) {
    restart();
  }

  restart({Duration time = Duration.zero}) {
    // android坐标是 向下 和  向右 为正
    final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 1.2);
    final endPosition = Offset(-0.2 + 1.4 * random.nextDouble(), -0.2);
    final duration = Duration(milliseconds: 500 + random.nextInt(1000));

    tween = MultiTrackTween([
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOutSine),
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeIn),
    ]);
    animationProgress = AnimationProgress(duration: duration, startTime: time);
    size = 0.2 + random.nextDouble() * 0.4;
  }

  maintainRestart(Duration time) {
    if (animationProgress.progress(time) == 1.0) {
      restart(time: time);
    }
  }
}
