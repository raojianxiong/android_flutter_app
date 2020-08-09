import 'package:android_flutter_app/generated/json/base/json_convert_content.dart';

class SkillCategoryEntity with JsonConvert<SkillCategoryEntity> {
	List<SkillCategorychild> children;
	int courseId;
	int id;
	String name;
	int order;
	int parentChapterId;
	int visible;
}

class SkillCategorychild with JsonConvert<SkillCategorychild> {
	List<dynamic> children;
	int courseId;
	int id;
	String name;
	int order;
	int parentChapterId;
	int visible;
}
