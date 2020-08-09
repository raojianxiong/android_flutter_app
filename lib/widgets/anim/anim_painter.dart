import 'package:android_flutter_app/widgets/anim/anim_model.dart';
import 'package:flutter/material.dart';

class LoginAnimPainter extends CustomPainter {
  List<LoginAnimModel> anims;
  Duration time;

  LoginAnimPainter(this.anims, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withAlpha(50);
    anims.forEach((element) {
      var progress = element.animationProgress.progress(time);
      final animation = element.tween.transform(progress);
      final position =
          Offset(animation["x"] * size.width, animation["y"] * size.height);
      canvas.drawCircle(position, size.width*0.2 * element.size, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
