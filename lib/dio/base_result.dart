import 'package:android_flutter_app/generated/json/base/json_convert_content.dart';
import 'package:json_annotation/json_annotation.dart';
//part  'base_result.g.dart'

class BaseResult<T> {
  int errorCode;
  String errorMsg;
  T data;

  BaseResult({this.errorCode, this.errorMsg, this.data});

  factory BaseResult.fromJson(Map<String, dynamic> json) {
    return BaseResult(
      errorCode: json["errorCode"],
      errorMsg: json["errorMsg"],
      data: JsonConvert.fromJsonAsT<T>(json["data"]),//只解析插件自动生成的实体类
    );
  }
//

}

//@JsonSerializable()
class BaseListResult<T> {
  int errorCode;
  String errorMsg;
  List<T> data;

  BaseListResult({this.errorCode, this.errorMsg, this.data});


  //_getListFromType
  factory BaseListResult.fromJson(Map<String, dynamic> json) {
    return BaseListResult(
      errorCode: json["errorCode"],
      errorMsg: json["errorMsg"],
      data: List.of(json["data"])
          .map((i) => JsonConvert.fromJsonAsT<T>(i) /* can't generate it properly yet */)
          .toList(),
    );
  }

  //转换成json缓存时需要注意
//  Map<String, dynamic> toJson() {
//    return {
//      "errorCode": this.errorCode,
//      "errorMsg": this.errorMsg,
//      "data": this.data.map((e) => e.toJson()).toList(),
//    };
//  }
}
