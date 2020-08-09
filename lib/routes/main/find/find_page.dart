import 'dart:convert';
import 'dart:io';

import 'package:android_flutter_app/common/global.dart';
import 'package:android_flutter_app/common/utils.dart';
import 'package:android_flutter_app/config/api_url.dart';
import 'package:android_flutter_app/config/router_name_config.dart';
import 'package:android_flutter_app/dio/dio_manager.dart';
import 'package:android_flutter_app/dio/request_method.dart';
import 'package:android_flutter_app/l10n/localization_intl.dart';
import 'package:android_flutter_app/models/skill_category_entity.dart';
import 'package:android_flutter_app/widgets/loading_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FindPage extends StatefulWidget {
  @override
  _FindStatePage createState() {
    return _FindStatePage();
  }
}

class _FindStatePage extends State<FindPage>
    with AutomaticKeepAliveClientMixin {
  List<SkillCategoryEntity> _mData = List();
  List<Color> _colors = Global.colors;
  var firstIndex = 0;
  var secondIndex = 0;
  final double height = 45;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _getTreeTypeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: LoadingContainer(
        isLoading: _isLoading,
        child: Column(
          children: <Widget>[
            _appBar,
            Expanded(
              //这里去掉Expanded会报错哦 撑满剩余空间
              child: _content,
            ),
          ],
        ),
      )),
    );
  }

  get _content {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _leftWidget(),
        _rightWidget(),
      ],
    );
  }

  Widget _leftWidget() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width / 3,
        minWidth: MediaQuery.of(context).size.width / 3,
        minHeight: double.infinity, //高度尽可能的大
      ),
      color: Colors.grey[200],
      child: ListView.builder(
          itemCount: _mData != null ? _mData.length : 0,
          itemBuilder: (context, index) => _leftItemBuild(index)),
    );
  }

  Widget _rightWidget() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //每行2个
              crossAxisSpacing: 10, //横轴Item间距
              mainAxisSpacing: 10,
              childAspectRatio:
                  (MediaQuery.of(context).size.width / 3 * 2 - 20) / 2 / height,
            ),
            itemCount: (_mData == null ||
                    _mData.length == 0 ||
                    _mData[firstIndex].children == null)
                ? 0
                : _mData[firstIndex].children.length,
            itemBuilder: (context, index) => _rightItemBuild(index)),
      ),
    );
  }

  Widget _leftItemBuild(index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          firstIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        alignment: Alignment.centerLeft,
        color: index == firstIndex
            ? _colors[index % _colors.length]
            : Colors.grey[200],
        child: Text(
          _mData[index].name,
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 16.0,
              color: index == firstIndex ? Colors.white : Colors.black26),
        ),
      ),
    );
  }

  Widget _rightItemBuild(index) {
    return GestureDetector(
      onTap: () {
        //跳转
        String json = jsonEncode({
          "list": _mData[firstIndex].children,
          "index": index,
          "title": _mData[firstIndex].name
        });
        startPageOnly(context, RouterNameConfig.SECOND_LEVEL_NAME,
            arguments: json);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Text(
          _mData[firstIndex].children[index].name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style:
              TextStyle(fontSize: 14, color: _colors[index % _colors.length]),
        ),
      ),
    );
  }

  get _appBar {
    return Container(
      height: 40,
      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.blue, width: 0.5),
      ),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              color: Colors.blue,
            ),
            Expanded(
              child: Text(
                GmLocalization.of(context).searchHint,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
        onTap: () {
          startPageOnly(context, RouterNameConfig.SEARCH_NAME);
        },
      ),
    );
  }

  _getTreeTypeList() {
    DioManager.getInstance().requestList<SkillCategoryEntity>(
        RequestMethod.GET, ApiUrl.getInstance().treeList, success: (data) {
      setState(() {
        _mData = data;
        _isLoading = false;
      });
    }, error: (error) {
      showToast(error.errorMsg);
      setState(() {
        _isLoading = false;
      });
    });
  }

  //每次显示该界面都不会重新构建请求网络了
  @override
  bool get wantKeepAlive => true;
}
