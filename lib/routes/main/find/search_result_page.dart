import 'package:android_flutter_app/common/utils.dart';
import 'package:android_flutter_app/config/api_url.dart';
import 'package:android_flutter_app/dio/dio_manager.dart';
import 'package:android_flutter_app/dio/request_method.dart';
import 'package:android_flutter_app/models/article_list_entity.dart';
import 'package:android_flutter_app/routes/main/home/article_item_view.dart';
import 'package:android_flutter_app/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class SearchResultPage extends StatefulWidget{

  String keyWord ="";
  SearchResultPage(this.keyWord);

  @override
  State<StatefulWidget> createState() {
    return _SearchResultPageState();
  }

}
class _SearchResultPageState extends State<SearchResultPage>{
  int total = 0;
  int pageNum = 0;
  List<ArticleListData> mArticleData = List();
  ScrollController _scrollController = ScrollController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if(mArticleData != null && mArticleData.length < total &&
      _scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _getArticleList(loadingMore: true);
      }
    });
    _getArticleList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.keyWord,),
      ),
      body:  LoadingContainer(
        isLoading: _isLoading,
        child:RefreshIndicator(
          onRefresh: _onRefresh,
          child:  _listView(),
        ),
      ),
    );
  }

  Widget _listView() {
    return ListView.builder(
        controller: _scrollController,
        itemCount: mArticleData.length ,
        itemBuilder: (context, index) {
          return _renderItem(index);
        });
  }
  _renderItem(index) {
    ArticleListData item = mArticleData[index];
    return ArticleItemView(item);
  }

  Future<void> _onRefresh() async {
    pageNum = 0;
    await _getArticleList();
  }

  _getArticleList({loadingMore = false}) {
    if (loadingMore) {
      pageNum++;
    }
    DioManager.getInstance().request<ArticleListEntity>(
        RequestMethod.POST, sprintf(ApiUrl.getInstance().searchList, [pageNum]),
        params: {"k":widget.keyWord}, success: (data) {
      setState(() {
        _isLoading = false;
        total = data.total;
        if (pageNum == 0) {
          mArticleData = data.datas;
        } else {
          mArticleData.addAll(data.datas);
        }
      });
    }, error: (error) {
      showToast(error.errorMsg);
      setState(() {
        _isLoading = false;
      });
    });
  }

}