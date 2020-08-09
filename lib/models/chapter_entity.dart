import 'package:android_flutter_app/generated/json/base/json_convert_content.dart';

class ChapterEntity with JsonConvert<ChapterEntity> {
	List<dynamic> children;
	int courseId;
	int id;
	String name;
	int order;
	int parentChapterId;
	bool userControlSetTop;
	int visible;
}
