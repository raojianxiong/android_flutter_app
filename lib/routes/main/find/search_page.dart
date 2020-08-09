import 'dart:convert';

import 'package:android_flutter_app/common/global.dart';
import 'package:android_flutter_app/common/utils.dart';
import 'package:android_flutter_app/config/api_url.dart';
import 'package:android_flutter_app/config/router_name_config.dart';
import 'package:android_flutter_app/dio/dio_manager.dart';
import 'package:android_flutter_app/dio/request_method.dart';
import 'package:android_flutter_app/l10n/localization_intl.dart';
import 'package:android_flutter_app/models/hot_key_entity.dart';
import 'package:android_flutter_app/models/web_site_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  List<Color> _colors = Global.colors;

  //热搜
  List<HotKeyEntity> _hotKeyList;

  //常用网站
  List<WebSiteEntity> _webSiteList;

  @override
  void initState() {
    super.initState();
    _getHotKey();
    _getUsuallyWebSite();
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalization.of(context);
    return Scaffold(
        appBar: AppBar(
          title: _searchField(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _startPageToSearch(_searchController.text);
              },
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _searchController.clear();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      gm.searchWithUs,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _hotKeyWidget(),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      gm.usuallyWebsite,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _usuallyWebSiteWidget(),
                ),
              ),
            ],
          ),
        ));
  }

  _hotKeyWidget() {
    List<Widget> list = List();
    if (_hotKeyList == null) {
      return list;
    }

    for (var i = 0; i < _hotKeyList.length; i++) {
      var item = _hotKeyList[i];
      Widget widget = GestureDetector(
        onTap: () {
          _startPageToSearch(item.name);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(45),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Text(
              item.name,
              style: TextStyle(color: _colors[i % _colors.length]),
            ),
          ),
        ),
      );
      list.add(widget);
    }
    return list;
  }

  _usuallyWebSiteWidget() {
    List<Widget> list = List();
    if (_webSiteList == null) {
      return list;
    }
    for (var i = 0; i < _webSiteList.length; i++) {
      var item = _webSiteList[i];
      Widget widget = GestureDetector(
        onTap: () {
          startPageOnly(context, RouterNameConfig.WEBVIEW_NAME,
              arguments: jsonEncode({"url": item.link, "title": item.name}));
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(45),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Text(
              item.name,
              style: TextStyle(color: _colors[i % _colors.length]),
            ),
          ),
        ),
      );
      list.add(widget);
    }
    return list;
  }

  _searchField() {
    return TextField(
      focusNode: _focusNode,
      controller: _searchController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: GmLocalization.of(context).searchInputHint,
        hintStyle: TextStyle(color: Colors.white70),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.pink[700],
      textInputAction: TextInputAction.search,
      onSubmitted: (text) {
        _startPageToSearch(text);
      },
    );
  }

  _startPageToSearch(keyword) {
    //关闭键盘
    _focusNode.unfocus();
    if (keyword == null || keyword.isEmpty) {
      showToast(GmLocalization.of(context).searchInputHint);
      return;
    }
    startPageOnly(context, RouterNameConfig.SEARCH_RESULT_NAME,
        arguments: keyword);
  }

  _getHotKey() {
    DioManager.getInstance().requestList<HotKeyEntity>(
        RequestMethod.GET, ApiUrl.getInstance().hotKeyList, params: {},
        success: (data) {
      setState(() {
        _hotKeyList = data;
      });
    }, error: (error) {
      showToast(error.errorMsg);
    });
  }

  _getUsuallyWebSite() {
    DioManager.getInstance().requestList<WebSiteEntity>(
        RequestMethod.GET, ApiUrl.getInstance().linkList,
        params: {}, success: (data) {
      setState(() {
        _webSiteList = data;
      });
    }, error: (error) {
      showToast(error.errorMsg);
    });
  }
}
