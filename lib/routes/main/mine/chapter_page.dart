import 'package:android_flutter_app/common/utils.dart';
import 'package:android_flutter_app/config/api_url.dart';
import 'package:android_flutter_app/dio/dio_manager.dart';
import 'package:android_flutter_app/dio/request_method.dart';
import 'package:android_flutter_app/l10n/localization_intl.dart';
import 'package:android_flutter_app/models/chapter_entity.dart';
import 'package:flutter/material.dart';

import 'chapter_list_page.dart';

class ChapterPage extends StatefulWidget {
  @override
  _ChapterPageState createState() {
    return _ChapterPageState();
  }
}

class _ChapterPageState extends State<ChapterPage>
    with SingleTickerProviderStateMixin {
  List<ChapterEntity> _mData = List();

  @override
  void initState() {
    super.initState();
    _getChaptersList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _mData.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(GmLocalization.of(context).chapter),
          bottom: TabBar(
            isScrollable: true,
            tabs: _mData.map((e) {
              return Tab(text: e.name);
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: _mData.map((e) {
            return ChaptersListPage(e.id);
          }).toList(),
        ),
      ),
    );
  }

  _getChaptersList() {
    DioManager.getInstance().requestList<ChapterEntity>(
        RequestMethod.GET, ApiUrl.getInstance().chapters,
        params: {}, success: (data) {
      setState(() {
        _mData = data;
      });
    }, error: (error) {
      showToast(error.errorMsg);
    });
  }
}
