import 'package:android_flutter_app/common/utils.dart';
import 'package:android_flutter_app/config/api_url.dart';
import 'package:android_flutter_app/dio/dio_manager.dart';
import 'package:android_flutter_app/dio/request_method.dart';
import 'package:android_flutter_app/models/article_list_entity.dart';
import 'package:android_flutter_app/routes/main/home/article_item_view.dart';
import 'package:android_flutter_app/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

///这个类 相关方法都写了很多次了，可以抽取出来
class ChaptersListPage extends StatefulWidget{
  int id;
  ChaptersListPage(this.id);
  @override
  _ChaptersListPageState createState() {
    return _ChaptersListPageState();
  }

}
class _ChaptersListPageState extends State<ChaptersListPage>{

  int pageNum = 0;
  int total;
  List<ArticleListData> mArticleData;
  ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (mArticleData != null && mArticleData.length < total &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        _getArticleList(loadingMore: true);
      }
    });
    _getArticleList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: LoadingContainer(
        isLoading: _isLoading,
        child: ListView.builder(
            controller: _scrollController,
            itemCount: mArticleData != null ? mArticleData.length :0,
            itemBuilder: (context, index) {
              return _buildItem(index);
            }),
      ),
    );
  }

  _buildItem(index) {
    return ArticleItemView(mArticleData[index]);
  }

  Future<void> _onRefresh() async {
    await _getArticleList();
  }

  _getArticleList({loadingMore = false}) {
    if (loadingMore) {
      pageNum++;
    }
    DioManager.getInstance().request<ArticleListEntity>(
        RequestMethod.GET, sprintf(ApiUrl
        .getInstance()
        .articleList, [widget.id,pageNum]),
        params: { }, success: (data) {
      setState(() {
        total = data.total;
        if (pageNum == 0) {
          mArticleData = data.datas;
        } else {
          mArticleData.addAll(data.datas);
        }
        _isLoading =false;
      });

    }, error: (error) {
      showToast(error.errorMsg);
      setState(() {
        _isLoading = false;
      });
    });
  }
}
