import 'package:android_flutter_app/models/skill_category_entity.dart';

skillCategoryEntityFromJson(SkillCategoryEntity data, Map<String, dynamic> json) {
	if (json['children'] != null) {
		data.children = new List<SkillCategorychild>();
		(json['children'] as List).forEach((v) {
			data.children.add(new SkillCategorychild().fromJson(v));
		});
	}
	if (json['courseId'] != null) {
		data.courseId = json['courseId']?.toInt();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['order'] != null) {
		data.order = json['order']?.toInt();
	}
	if (json['parentChapterId'] != null) {
		data.parentChapterId = json['parentChapterId']?.toInt();
	}
	if (json['visible'] != null) {
		data.visible = json['visible']?.toInt();
	}
	return data;
}

Map<String, dynamic> skillCategoryEntityToJson(SkillCategoryEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.children != null) {
		data['children'] =  entity.children.map((v) => v.toJson()).toList();
	}
	data['courseId'] = entity.courseId;
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['order'] = entity.order;
	data['parentChapterId'] = entity.parentChapterId;
	data['visible'] = entity.visible;
	return data;
}

skillCategorychildFromJson(SkillCategorychild data, Map<String, dynamic> json) {
	if (json['children'] != null) {
		data.children = new List<dynamic>();
		data.children.addAll(json['children']);
	}
	if (json['courseId'] != null) {
		data.courseId = json['courseId']?.toInt();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['order'] != null) {
		data.order = json['order']?.toInt();
	}
	if (json['parentChapterId'] != null) {
		data.parentChapterId = json['parentChapterId']?.toInt();
	}
	if (json['visible'] != null) {
		data.visible = json['visible']?.toInt();
	}
	return data;
}

Map<String, dynamic> skillCategorychildToJson(SkillCategorychild entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.children != null) {
		data['children'] =  [];
	}
	data['courseId'] = entity.courseId;
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['order'] = entity.order;
	data['parentChapterId'] = entity.parentChapterId;
	data['visible'] = entity.visible;
	return data;
}