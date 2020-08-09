import 'package:android_flutter_app/generated/json/base/json_convert_content.dart';

class HotKeyEntity with JsonConvert<HotKeyEntity> {
	int id;
	String link;
	String name;
	int order;
	int visible;
}
