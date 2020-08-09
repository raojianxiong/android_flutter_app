import 'package:android_flutter_app/generated/json/base/json_convert_content.dart';

class ErrorMsgEntity with JsonConvert<ErrorMsgEntity> {
	int errorCode;
	String errorMsg;

	ErrorMsgEntity({this.errorCode, this.errorMsg});
}
