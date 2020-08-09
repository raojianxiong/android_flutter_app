import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import 'anim_model.dart';
import 'anim_painter.dart';

///https://pub.flutter-io.cn/packages/simple_animations/example

class LoginBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final tween = MultiTween<DefaultAnimationProperties>()
      ..add(DefaultAnimationProperties.color1,
          ColorTween(begin: Color(0xffD38312), end: Colors.lightBlue.shade900),
          Duration(seconds: 3))..add(DefaultAnimationProperties.color2,
          ColorTween(begin: Color(0xffA83279), end: Colors.blue.shade600),
          Duration(seconds: 3));
    return CustomAnimation(
      control: CustomAnimationControl.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  value.get(DefaultAnimationProperties.color1),
                  value.get(DefaultAnimationProperties.color2)
                ]),
          ),
        );
      },
    );
  }
}

class LoginAnimWidget extends StatefulWidget {
  final int numberOfLoginAnim;

  LoginAnimWidget(this.numberOfLoginAnim);

  @override
  _LoginAnimState createState() {
    return _LoginAnimState();
  }
}

class _LoginAnimState extends State<LoginAnimWidget> {
  final Random random = Random();
  final List<LoginAnimModel> anims = [];

  @override
  void initState() {
    List.generate(
        widget.numberOfLoginAnim, (index) => anims.add(LoginAnimModel(random)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Rendering(
      startTime: Duration(seconds: 30),
      onTick: _simulateLoginAnims,
      builder: (context, time) {
        return CustomPaint(
          painter: LoginAnimPainter(anims, time),
        );
      },
    );
  }

  _simulateLoginAnims(Duration time) {
    anims.forEach((element) {
      element.maintainRestart(time);
    });
  }
}
