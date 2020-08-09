import 'package:android_flutter_app/generated/json/base/json_convert_content.dart';

class BannerInfoEntity with JsonConvert<BannerInfoEntity> {
	String desc;
	int id;
	String imagePath;
	int isVisible;
	int order;
	String title;
	int type;
	String url;
}
