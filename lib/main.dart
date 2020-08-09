import 'dart:convert';

import 'package:android_flutter_app/common/application_context.dart';
import 'package:android_flutter_app/config/router_name_config.dart';
import 'package:android_flutter_app/generated/json/base/json_convert_content.dart';
import 'package:android_flutter_app/l10n/localization_intl.dart';
import 'package:android_flutter_app/routes/main/detail/article_detail_page.dart';
import 'package:android_flutter_app/routes/main/find/search_page.dart';
import 'package:android_flutter_app/routes/main/find/search_result_page.dart';
import 'package:android_flutter_app/routes/main/find/second_level_page.dart';
import 'package:android_flutter_app/routes/main/mine/chapter_page.dart';
import 'package:android_flutter_app/routes/main/mine/new_project_page.dart';
import 'package:android_flutter_app/routes/main/mine/picture_item_page.dart';
import 'package:android_flutter_app/routes/main/mine/picture_page.dart';
import 'package:android_flutter_app/routes/main/mine/switch_language_page.dart';
import 'package:android_flutter_app/states/change_notifier.dart';
import 'file:///E:/AndroidStudioWorkSpace/android_flutter_app/android_flutter_app/lib/routes/login/login_page.dart';
import 'file:///E:/AndroidStudioWorkSpace/android_flutter_app/android_flutter_app/lib/routes/main/main_page.dart';
import 'file:///E:/AndroidStudioWorkSpace/android_flutter_app/android_flutter_app/lib/routes/login/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'common/global.dart';
import 'models/skill_category_entity.dart';

void main() {
  Global.init().then((e) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  ///注册路由表
  final Map<String, WidgetBuilder> _routers = {
    RouterNameConfig.WELCOME_NAME: (context) => WelcomePage(),
    RouterNameConfig.LOGIN_NAME: (context) => LoginPage(),
    RouterNameConfig.REGISTER_NAME: (context) => RegisterPage(),
    RouterNameConfig.MAIN_NAME: (context) => MainPage(),
    RouterNameConfig.WEBVIEW_NAME: (context) => DetailWebView(),
    RouterNameConfig.SECOND_LEVEL_NAME: (context) => SecondLevelPage(
          children: JsonConvert.fromJsonAsT<List<SkillCategorychild>>(
              jsonDecode(ModalRoute.of(context).settings.arguments)["list"]),
          index: jsonDecode(ModalRoute.of(context).settings.arguments)["index"],
          title: jsonDecode(ModalRoute.of(context).settings.arguments)["title"],
        ),
    RouterNameConfig.SEARCH_NAME: (context) => SearchPage(),
    RouterNameConfig.SEARCH_RESULT_NAME: (context) => SearchResultPage(ModalRoute.of(context).settings.arguments),
    RouterNameConfig.CHAPTER_NAME  : (context) => ChapterPage(),
    RouterNameConfig.NEW_PROJECT_NAME  : (context) => NewProjectPage(),
    RouterNameConfig.SWITCH_LANGUAGE  : (context) => LanguagePage(),
    RouterNameConfig.PICTURE_NAME  : (context) => PicturePage(),
    RouterNameConfig.PICTURE_ITEM_NAME  : (context) => PictureItemPage(),
  };

  @override
  Widget build(BuildContext context) {
    GlobalApplicationContext.init(context);
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
//        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel())
      ],
      child: Consumer<LocaleModel>(
        builder:(BuildContext context,localModel,Widget child){
          return MaterialApp(
            //国际化语言写法
            onGenerateTitle: (context) {
              return GmLocalization.of(context).title;
            },
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GmLocalizationDelegate()
            ],
            locale: localModel.getLocale(),
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('zh', 'CN'),
            ],
            routes: _routers,
            initialRoute: RouterNameConfig.WELCOME_NAME,
            localeResolutionCallback:
                (Locale _locale, Iterable<Locale> supportedLocales) {
              if (localModel.getLocale() != null) {
                //如果已经选定语言，则不跟随系统
                return localModel.getLocale();
              } else {
                //跟随系统
                Locale locale;
                if (supportedLocales.contains(_locale)) {
                  locale= _locale;
                } else {
                  //如果系统语言不是中文简体或美国英语，则默认使用美国英语
                  locale= Locale('en', 'US');
                }
                return locale;
              }
            },
          );
        },
      ),
    );
  }
}

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image(
        image: AssetImage("images/welcome_bg.png"),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }

  _initData() {
    Future.delayed(Duration(seconds: 1), () {
      //这里假设通过有没有存用户名来判断 网络层做了Cookie持久化
      if(Global.profile.user != null && Global.profile.user.username.isNotEmpty){
        Navigator.pushNamedAndRemoveUntil(
            context, RouterNameConfig.MAIN_NAME, (route) => false);
      }else {
        Navigator.pushNamedAndRemoveUntil(
            context, RouterNameConfig.LOGIN_NAME, (route) => false);
      }
    });
  }
}
