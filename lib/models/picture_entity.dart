import 'package:android_flutter_app/generated/json/base/json_convert_content.dart';
import 'package:android_flutter_app/generated/json/base/json_filed.dart';

class PictureEntity with JsonConvert<PictureEntity> {
	@JSONField(name: "_id")
	String sId;
	String author;
	String category;
	String createdAt;
	String desc;
	List<String> images;
	int likeCounts;
	String publishedAt;
	int stars;
	String title;
	String type;
	String url;
	int views;
}
