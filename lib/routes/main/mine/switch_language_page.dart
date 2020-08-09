import 'package:android_flutter_app/l10n/localization_intl.dart';
import 'package:android_flutter_app/states/change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  GmLocalization gm;
  LocaleModel localeModel ;
  @override
  Widget build(BuildContext context) {
    gm = GmLocalization.of(context);
    localeModel  = Provider.of<LocaleModel>(context);
    return Scaffold(
      appBar: AppBar(
        title:Text(gm.language),
      ),
      body: ListView(
        children: <Widget>[
          _buildLanguageItem(gm.zhCn, "zh_CN"),
          _buildLanguageItem(gm.enUs, "en_US"),
          _buildLanguageItem(gm.auto, null)
        ],
      ),
    );
  }

  _buildLanguageItem(lan,value){
    return ListTile(
      title: Text(lan,style: TextStyle(color: localeModel.locale == value ? Colors.blue:null),),
      trailing: localeModel.locale == value ? Icon(Icons.done,color: Colors.blue,) :null,
      onTap: (){
        //通知MaterialApp重新build
        localeModel.locale = value;
      },
    );
  }
}