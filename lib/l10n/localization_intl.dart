import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class GmLocalization {
  static Future<GmLocalization> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    //下面方法使用可以看Flutter中文网13.3
    //1.flutter pub run intl_translation:extract_to_arb --output-dir=l10n-arb lib/l10n/localization_intl.dart
    //2.git bash ->执行(windows上指定文件执行) flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n  --no-use-deferred-loading lib/l10n/*.dart l10n-arb/*.arb
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new GmLocalization();
    });
  }

  static GmLocalization of(BuildContext context) {
    return Localizations.of<GmLocalization>(context, GmLocalization);
  }

  String get title {
    return Intl.message(
      'Flutter APP',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }

  String get home => Intl.message('Home', name: 'home');
  String get find => Intl.message('Find', name: 'find');
  String get message => Intl.message('Message', name: 'message');
  String get mine => Intl.message('Mine', name: 'mine');

  String get userNameRequired =>
      Intl.message("User name required!", name: 'userNameRequired');

  String get userName => Intl.message('User Name', name: 'userName');

  String get password => Intl.message('Password', name: 'password');

  String get passwordRequired =>
      Intl.message('Password required!', name: 'passwordRequired');

  String get userNameOrPasswordWrong =>
      Intl.message('User name or password is not correct!',
          name: 'userNameOrPasswordWrong');

  String get login => Intl.message('Login', name: 'login');
  String get register => Intl.message('Register', name: 'register');

  String get netError => Intl.message("Unknow Error", name: "netError");
  String get netCancel => Intl.message("Request Cancel", name: "netCancel");
  String get netConnectTimeOut => Intl.message("Connect Timeout", name: "netConnectTimeOut");
  String get netRequestTimeOut => Intl.message("Request Timeout", name: "netRequestTimeOut");
  String get netResponseTimeOut => Intl.message("Response Timeout", name: "netResponseTimeOut");
  String get loginSuccess => Intl.message("Login Success!", name: "loginSuccess");
  String get inputNameHint => Intl.message("Please input account", name: "inputNameHint");
  String get inputPwdHint => Intl.message("Please input password", name: "inputPwdHint");
  String get inputConfirmPwdHint => Intl.message("Please Confirm password", name: "inputConfirmPwdHint");
  String get confirmPwdError => Intl.message("password not the same", name: "confirmPwdError");
  String get category => Intl.message("category ", name: "category");
  String get publishTime => Intl.message("publishTime: ", name: "publishTime");
  String get share => Intl.message("share", name: "share");
  String get searchHint => Intl.message("Hot", name: "searchHint");
  String get searchInputHint => Intl.message("Please input keyword",name: "searchInputHint");
  String get searchWithUs => Intl.message("Hot Search",name: "searchWithUs");
  String get usuallyWebsite => Intl.message("Usually WebSite",name: "usuallyWebsite");
  String get messageNotOpen => Intl.message("Message Module is on the way",name: "messageNotOpen");
  String get newProject => Intl.message("Lasted Project",name: "newProject");
  String get chapter => Intl.message("Chapter",name: "chapter");
  String get welfare => Intl.message("Welfare",name: "welfare");
  String get casual => Intl.message("Casual",name: "casual");
  String get about => Intl.message("About",name: "about");
  String get language => Intl.message("Switch Language",name: "language");
  String get logout => Intl.message("Logout",name: "logout");
  String get zhCn => Intl.message("中文简体",name: "zhCn");
  String get enUs => Intl.message("English",name: "enUs");
  String get auto => Intl.message("Follow System",name: "auto");
  String get exitHint => Intl.message("Confirm Logout?",name: "exitHint");
  String get ok => Intl.message("OK",name: "ok");
  String get cancel => Intl.message("Cancel",name: "cancel");
}

//Local代理类
class GmLocalizationDelegate extends LocalizationsDelegate<GmLocalization> {
  const GmLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    // 是否支持某个Local
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<GmLocalization> load(Locale locale) {
    // Flutter会调用此类加载相应的Locale资源类
    return GmLocalization.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<GmLocalization> old) {
    // 当Localization Widget重新build时，是否调用load重新加载Locale资源
    return false;
  }
}
