import 'dart:convert';

import 'package:android_flutter_app/common/utils.dart';
import 'package:android_flutter_app/config/api_url.dart';
import 'package:android_flutter_app/config/router_name_config.dart';
import 'package:android_flutter_app/dio/dio_manager.dart';
import 'package:android_flutter_app/dio/request_method.dart';
import 'package:android_flutter_app/l10n/localization_intl.dart';
import 'package:android_flutter_app/models/picture_entity.dart';
import 'package:android_flutter_app/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sprintf/sprintf.dart';

class PicturePage extends StatefulWidget {
  @override
  _PicturePageState createState() {
    return _PicturePageState();
  }
}

class _PicturePageState extends State<PicturePage> {
  int _pageNum = 1;
  List<PictureEntity> _mPictures = List();
  bool _isLoading = true;
  ScrollController _scrollController = ScrollController();
  int _total;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_mPictures != null &&
          _mPictures.length < _total &&
          _scrollController.position.maxScrollExtent ==
              _scrollController.position.pixels) {
        _getPictureData(loadingMore: true);
      }
    });
    _getPictureData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalization.of(context).welfare),
      ),
      body: LoadingContainer(
        isLoading: _isLoading,
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: StaggeredGridView.countBuilder(
            itemCount: _mPictures != null ? _mPictures.length : 0,
              controller: _scrollController,
              crossAxisCount: 4,
              itemBuilder: (context, index) => _itemBuild(index),
              padding: EdgeInsets.all(5.0),
              staggeredTileBuilder: (index) =>
              //横轴 主轴 crossAxisCount/crossAxisCellCount = 多少列
                  StaggeredTile.count(2, index == 0 ? 2.5 : 3)),
        ),
      ),
    );
  }

  _itemBuild(index) {
    PictureEntity item = _mPictures[index];
    return Card(
      elevation: 2,
      child: PhysicalModel(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(5),
        child: GestureDetector(
          onTap: (){
            startPageOnly(context, RouterNameConfig.PICTURE_ITEM_NAME,arguments: jsonEncode({"url": item.url,"title":item.desc}));
          },
          child: Image.network(item.url,fit: BoxFit.fill,),
        )

      ),
    );
  }

  Future<void> _onRefresh() async {
    await _getPictureData();
  }

  _getPictureData({loadingMore = false}) {
    if (loadingMore) {
      _pageNum++;
    } else {
      _pageNum = 1;
    }
    DioManager.getInstance(baseUrl: ApiUrl.getInstance().gankBaseUrl)
        .requestGankIo<PictureEntity>(RequestMethod.GET,
            sprintf(ApiUrl.getInstance().gankGirl, [_pageNum]), params: {},
            success: (data) {
      setState(() {
        if (_pageNum == 1) {
          _mPictures = data.data;
          _isLoading = false;
          _total = data.total_counts;
        } else {
          _mPictures.addAll(data.data);
        }
      });
    }, error: (error) {
      showToast(error.errorMsg);
    });
  }
}
