import 'package:android_flutter_app/generated/json/base/json_convert_content.dart';

class WebSiteEntity with JsonConvert<WebSiteEntity> {
	String icon;
	int id;
	String link;
	String name;
	int order;
	int visible;
}
