import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_drag_scale/core/drag_scale_widget.dart';

class PictureItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var arguments = jsonDecode(ModalRoute.of(context).settings.arguments);
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments["title"]),
      ),
      body: DragScaleContainer(
        doubleTapStillScale: true,
        child: Image.network(
          arguments["url"],
        ),
      )
    );
  }
}
