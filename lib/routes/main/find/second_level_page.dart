import 'package:android_flutter_app/models/skill_category_entity.dart';
import 'package:android_flutter_app/routes/main/find/second_item_view.dart';
import 'package:flutter/material.dart';

class SecondLevelPage extends StatefulWidget {
  String title = "";
  int index = 0;
  List<SkillCategorychild> children;

  SecondLevelPage({Key key, this.children, this.index, this.title})
      : super(key: key);

  @override
  _SecondLevelPageState createState() {
    return _SecondLevelPageState();
  }
}

class _SecondLevelPageState extends State<SecondLevelPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
    _tabController = TabController(length: widget.children.length, vsync: this,initialIndex: _currentIndex);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: _tabBar,
      ),
      body: _contentView,
    );
  }

  get _tabBar {
    return TabBar(
      controller: _tabController,
      tabs: widget.children.map((e)  {return Tab(text: e.name,);}).toList(),
      isScrollable: true,
    );
  }

  get _contentView {
    return TabBarView(
      controller: _tabController,
      children: widget.children.map((e) {return _itemView(e);}).toList(),
    );
  }
  Widget _itemView(SkillCategorychild item){
    return SecondItemView(item.id);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
