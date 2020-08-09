import 'package:android_flutter_app/dio/errro_msg_entity.dart';

errorMsgEntityFromJson(ErrorMsgEntity data, Map<String, dynamic> json) {
	if (json['errorCode'] != null) {
		data.errorCode = json['errorCode']?.toInt();
	}
	if (json['errorMsg'] != null) {
		data.errorMsg = json['errorMsg']?.toString();
	}
	return data;
}

Map<String, dynamic> errorMsgEntityToJson(ErrorMsgEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['errorCode'] = entity.errorCode;
	data['errorMsg'] = entity.errorMsg;
	return data;
}