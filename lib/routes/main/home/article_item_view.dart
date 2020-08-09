import 'dart:convert';

import 'package:android_flutter_app/common/utils.dart';
import 'package:android_flutter_app/config/router_name_config.dart';
import 'package:android_flutter_app/l10n/localization_intl.dart';
import 'package:android_flutter_app/models/article_list_entity.dart';
import 'package:flutter/material.dart';

class ArticleItemView extends StatefulWidget {
  ArticleListData mData;

  ArticleItemView(this.mData);

  @override
  _ArticleItemViewState createState() {
    return _ArticleItemViewState(mData);
  }
}

class _ArticleItemViewState extends State<ArticleItemView> {
  ArticleListData mData;

  _ArticleItemViewState(this.mData);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
      clipBehavior: Clip.antiAlias,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: InkWell(
        onTap: () {
          startPageOnly(context, RouterNameConfig.WEBVIEW_NAME,
              arguments: jsonEncode({"url": mData.link, "title": mData.title}));
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildRowOne(),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              _buildRowTwo(),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              _buildRowThree(),
            ],
          ),
        ),
      ),
    );
  }

  _buildRowOne() {
    var gm = GmLocalization.of(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            (mData.author == null || mData.author.isEmpty)
                ? ((mData.shareUser == null || mData.shareUser.isEmpty)
                    ? gm.share
                    : mData.shareUser)
                : mData.author,
            style: TextStyle(color: Colors.amber[900]),
            textAlign: TextAlign.left,
          ),
        ),
        GestureDetector(
          onTap: () {
            _onCollectClick();
          },
          child: Icon(
            mData.collect ? Icons.favorite : Icons.favorite_border,
            color: mData.collect ? Colors.red : Colors.blue,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0),
        ),
        GestureDetector(
          onTap: () {
            _onShareClick();
          },
          child: Icon(
            Icons.share,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  _buildRowTwo() {
    return Text(
      mData.title,
      style: TextStyle(fontSize: 16),
      softWrap: true,
    );
  }

  _buildRowThree() {
    String content = mData.superChapterName + "/" + mData.chapterName;
    var gm = GmLocalization.of(context);
    String time = gm.publishTime + mData.niceDate;
    String category = gm.category;
    return Row(
      children: <Widget>[
        Text(category),
        Expanded(
          child: Text(
            content,
            textAlign: TextAlign.left,
            maxLines: 1,
            style: TextStyle(color: Colors.indigo[600]),
          ),
        ),
        Text(time),
      ],
    );
  }

  _onCollectClick() {}

  _onShareClick() {}

}
