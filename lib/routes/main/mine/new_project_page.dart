import 'dart:convert';

import 'package:android_flutter_app/common/utils.dart';
import 'package:android_flutter_app/config/api_url.dart';
import 'package:android_flutter_app/config/router_name_config.dart';
import 'package:android_flutter_app/dio/dio_manager.dart';
import 'package:android_flutter_app/dio/request_method.dart';
import 'package:android_flutter_app/l10n/localization_intl.dart';
import 'package:android_flutter_app/models/article_list_entity.dart';
import 'package:android_flutter_app/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class NewProjectPage extends StatefulWidget {
  @override
  _NewProjectPageState createState() {
    return _NewProjectPageState();
  }
}

class _NewProjectPageState extends State<NewProjectPage> {
  List<ArticleListData> _mData = List();
  int _pageNum = 0;
  int _total = 0;
  bool _isLoading = true;
  ScrollController _scrollController = ScrollController();
  GmLocalization gm;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_mData != null &&
          _mData.length < _total &&
          _scrollController.position.maxScrollExtent ==
              _scrollController.position.pixels) {
        _getArticleData(loadingMore: true);
      }
    });
    _getArticleData();
  }

  @override
  Widget build(BuildContext context) {
    gm = GmLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalization.of(context).newProject),
      ),
      body: LoadingContainer(
        isLoading: _isLoading,
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _item(index);
            },
            itemCount: _mData == null ? 0 : _mData.length,
            controller: _scrollController,
          ),
        ),
      ),
    );
  }

  _item(index) {
    ArticleListData item = _mData[index];
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: InkWell(
        onTap: () {
          startPageOnly(context, RouterNameConfig.WEBVIEW_NAME,
              arguments: jsonEncode({"url": item.link, "title": item.title}));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              image: NetworkImage(item.envelopePic),
              width: 80,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.title,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text(
                    item.desc,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        (item.author == null || item.author.isEmpty)
                            ? ((item.shareUser == null ||
                                    item.shareUser.isEmpty)
                                ? gm.share
                                : item.shareUser)
                            : item.author,
                        style: TextStyle(color: Colors.amber[900]),
                        textAlign: TextAlign.left,
                      ),
                      Expanded(
                        child: Text(
                          item.niceDate,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await _getArticleData();
  }

  _getArticleData({loadingMore: false}) {
    if (loadingMore) {
      _pageNum++;
    } else {
      _pageNum = 0;
    }
    DioManager.getInstance().request<ArticleListEntity>(
        RequestMethod.GET, sprintf(ApiUrl.getInstance().newProjectList, [_pageNum]),
        params: {}, success: (data) {
      setState(() {
        _total = data.total;
        if (_pageNum == 0) {
          _mData = data.datas;
          _isLoading = false;
        } else {
          _mData.addAll(data.datas);
        }
      });
    }, error: (error) {
      showToast(error.errorMsg);
    });
  }
}
