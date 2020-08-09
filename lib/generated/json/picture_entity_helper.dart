import 'package:android_flutter_app/models/picture_entity.dart';

pictureEntityFromJson(PictureEntity data, Map<String, dynamic> json) {
	if (json['_id'] != null) {
		data.sId = json['_id']?.toString();
	}
	if (json['author'] != null) {
		data.author = json['author']?.toString();
	}
	if (json['category'] != null) {
		data.category = json['category']?.toString();
	}
	if (json['createdAt'] != null) {
		data.createdAt = json['createdAt']?.toString();
	}
	if (json['desc'] != null) {
		data.desc = json['desc']?.toString();
	}
	if (json['images'] != null) {
		data.images = json['images']?.map((v) => v?.toString())?.toList()?.cast<String>();
	}
	if (json['likeCounts'] != null) {
		data.likeCounts = json['likeCounts']?.toInt();
	}
	if (json['publishedAt'] != null) {
		data.publishedAt = json['publishedAt']?.toString();
	}
	if (json['stars'] != null) {
		data.stars = json['stars']?.toInt();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toString();
	}
	if (json['url'] != null) {
		data.url = json['url']?.toString();
	}
	if (json['views'] != null) {
		data.views = json['views']?.toInt();
	}
	return data;
}

Map<String, dynamic> pictureEntityToJson(PictureEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['_id'] = entity.sId;
	data['author'] = entity.author;
	data['category'] = entity.category;
	data['createdAt'] = entity.createdAt;
	data['desc'] = entity.desc;
	data['images'] = entity.images;
	data['likeCounts'] = entity.likeCounts;
	data['publishedAt'] = entity.publishedAt;
	data['stars'] = entity.stars;
	data['title'] = entity.title;
	data['type'] = entity.type;
	data['url'] = entity.url;
	data['views'] = entity.views;
	return data;
}