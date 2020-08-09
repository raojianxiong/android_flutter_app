import 'dart:ui';

import 'package:android_flutter_app/common/utils.dart';
import 'package:android_flutter_app/config/api_url.dart';
import 'package:android_flutter_app/dio/dio_manager.dart';
import 'package:android_flutter_app/dio/request_method.dart';
import 'package:android_flutter_app/models/article_list_entity.dart';
import 'package:android_flutter_app/models/banner_info_entity.dart';
import 'package:android_flutter_app/routes/main/home/article_item_view.dart';
import 'file:///E:/AndroidStudioWorkSpace/android_flutter_app/android_flutter_app/lib/routes/main/home/banner_view.dart';
import 'package:android_flutter_app/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprintf/sprintf.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeStatePage createState() {
    return _HomeStatePage();
  }
}

class _HomeStatePage extends State<HomePage> with AutomaticKeepAliveClientMixin {
  bool _loading = true;
  ScrollController _scrollController = ScrollController();
  List<BannerInfoEntity> mBannerData = List();

  int pageNum = 0;
  int total = 0;
  List<ArticleListData> mArticleData = List();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _getBannerData();
    _getArticleList();
    _scrollController.addListener(() {
      if (mArticleData.length < total &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        _getArticleList(loadingMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: LoadingContainer(
        isLoading: _loading,
        child: RefreshIndicator(
          //下拉刷新
          onRefresh: _handleRefresh,
          child: _listView(),
        ),
      ),
    ));
  }

  //这里后续可以封装成带有header和footer的组件
  Widget _listView() {
    return ListView.builder(
        controller: _scrollController,
        itemCount: mArticleData.length + 1,
        itemBuilder: (context, index) {
          return _buildItem(index);
        });
  }

  _buildItem(index) {
    if (index == 0) {
      return BannerView(mBannerData);
    } else {
      return _renderItem(index - 1);
    }
  }

  _renderItem(index) {
    ArticleListData item = mArticleData[index];
    return ArticleItemView(item);
  }

  _getArticleList({loadingMore = false}) {
    if (loadingMore) {
      pageNum++;
    }
    DioManager.getInstance().request<ArticleListEntity>(
        RequestMethod.GET, sprintf(ApiUrl.getInstance().articleList, [pageNum]),
        params: {}, success: (data) {
      setState(() {
        total = data.total;
        if (pageNum == 0) {
          mArticleData = data.datas;
        } else {
          mArticleData.addAll(data.datas);
        }
      });
    }, error: (error) {
      showToast(error.errorMsg);
    });
  }

  _getBannerData() {
    DioManager.getInstance().requestList<BannerInfoEntity>(
        RequestMethod.GET, ApiUrl.getInstance().banner,
        params: {}, success: (data) {
      setState(() {
        mBannerData = data;
        _loading = false;
      });
    }, error: (error) {
      showToast(error.errorMsg);
      setState(() {
        _loading = false;
      });
    });
  }

  Future<void> _handleRefresh() async {
    pageNum = 0;
    await _getArticleList();
  }

  //每次显示该界面都不会重新构建请求网络了
  @override
  bool get wantKeepAlive => true;
}
