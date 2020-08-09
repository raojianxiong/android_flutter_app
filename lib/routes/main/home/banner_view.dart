import 'dart:convert';

import 'package:android_flutter_app/common/utils.dart';
import 'package:android_flutter_app/config/router_name_config.dart';
import 'package:android_flutter_app/models/banner_info_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BannerView extends StatefulWidget {
  List<BannerInfoEntity> data;

  BannerView(this.data);

  @override
  _BannerViewState createState() {
    return _BannerViewState();
  }
}

class _BannerViewState extends State<BannerView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          //AppBar渐变遮罩背景
          colors: [Color(0x66000000), Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: 160,
      child: Swiper(
        itemCount: widget.data.length,
        autoplay: true,
        itemBuilder: (context, index) {
          return _buildItem(index);
        },
        pagination: SwiperPagination(),
      ),
    );
  }

  _buildItem(index) {
    BannerInfoEntity item = widget.data[index];
    return GestureDetector(
      onTap: () {
        startPageOnly(context, RouterNameConfig.WEBVIEW_NAME,
            arguments: jsonEncode({
              "url": item.url,
              "title": item.title,
            }));
      },
      child: Stack(
        children: <Widget>[
          FractionallySizedBox(
            widthFactor: 1,
            child: Image.network(
              item.imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomLeft, //坐标原点为父控件左上角
            child: Container(
              color: Color(0x50000000),
              padding: EdgeInsets.all(5.0),
              child: Text(
                item.title,
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
