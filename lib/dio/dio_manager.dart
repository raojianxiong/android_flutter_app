import 'dart:io';

import 'package:android_flutter_app/common/application_context.dart';
import 'package:android_flutter_app/common/global.dart';
import 'package:android_flutter_app/config/api_url.dart';
import 'package:android_flutter_app/dio/base_result.dart';
import 'package:android_flutter_app/dio/gank_base_result.dart';
import 'package:android_flutter_app/dio/request_method.dart';
import 'package:android_flutter_app/l10n/localization_intl.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'errro_msg_entity.dart';

class DioManager {
  Dio _dio;
  PersistCookieJar cookieJar;
  static final DioManager _dioManager = DioManager._internal();

  static DioManager getInstance({String baseUrl}){
    if(baseUrl == null){
      return  _dioManager;
    }else{
      return _dioManager._baseUrl(baseUrl);
    }
  }
  _baseUrl(String baseUrl){
    if(_dio != null){
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  DioManager._internal() {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: ApiUrl.getInstance().baseUrl,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: false,
        connectTimeout: 30000,
        receiveTimeout: 3000,
      );
      _dio = Dio(options);
      _dio.interceptors.add(LogInterceptor(responseBody: Global.isDebug));
      getCookieJar()
          .then((value) => _dio.interceptors.add(CookieManager(value)));
    }
  }

  Future<PersistCookieJar> getCookieJar() async {
    if (cookieJar == null) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      cookieJar = PersistCookieJar(dir: appDocPath);
    }
    return cookieJar;
  }

  ///请求
  Future request<T>(RequestMethod method, String path,
      {Map<String, dynamic> params,
      Function(T) success,
      Function(ErrorMsgEntity) error}) async {
    try {
      Response response = await _dio.request(path,
          queryParameters: params,
          options: Options(method: RequestMethodValue[method]));
      if (response != null && response.statusCode == HttpStatus.ok) {
        BaseResult result = BaseResult<T>.fromJson(response.data);
        if (result.errorCode == 0) {
          success(result.data);
        } else {
          error(ErrorMsgEntity(
              errorCode: result.errorCode, errorMsg: result.errorMsg));
        }
      } else {
        error(ErrorMsgEntity(
            errorCode: -1,
            errorMsg:
                GmLocalization.of(GlobalApplicationContext.applicationContext)
                    .netError));
      }
    } on DioError catch (e) {
      error(createErrorEntity(e));
    }
  }

  Future requestList<T>(RequestMethod method, String path,
      {Map<String, dynamic> params,
      Function(List<T>) success,
      Function(ErrorMsgEntity) error}) async {
    try {
      Response response = await _dio.request(path,
          queryParameters: params,
          options: Options(method: RequestMethodValue[method]));
      if (response != null && response.statusCode == HttpStatus.ok) {
        BaseListResult result = BaseListResult<T>.fromJson(response.data);
        if (result.errorCode == 0) {
          success(result.data);
        } else {
          error(ErrorMsgEntity(
              errorCode: result.errorCode, errorMsg: result.errorMsg));
        }
      } else {
        error(ErrorMsgEntity(
            errorCode: -1,
            errorMsg:
                GmLocalization.of(GlobalApplicationContext.applicationContext)
                    .netError));
      }
    } on DioError catch (e) {
      error(createErrorEntity(e));
    }
  }

  ErrorMsgEntity createErrorEntity(DioError error) {
    var errorMsg;
    var gm = GmLocalization.of(GlobalApplicationContext.applicationContext);
    switch (error.type) {
      case DioErrorType.CANCEL:
        errorMsg = gm.netCancel;
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorMsg = gm.netConnectTimeOut;
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorMsg = gm.netRequestTimeOut;
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorMsg = gm.netResponseTimeOut;
        break;
      default:
        errorMsg = gm.netError;
        break;
    }
    return ErrorMsgEntity(errorCode: -1, errorMsg: errorMsg);
  }

  Future requestGankIo<T>(RequestMethod method, String path,
      {Map<String, dynamic> params,
        Function(GankIoBaseListResult<T>) success,
        Function(ErrorMsgEntity) error}) async {
    try {
      Response response = await _dio.request(path,
          queryParameters: params,
          options: Options(method: RequestMethodValue[method]));
      if (response != null && response.statusCode == HttpStatus.ok) {
        GankIoBaseListResult result = GankIoBaseListResult<T>.fromJson(response.data);
        if (result.status == 100) {
          success(result);
        } else {
          error(ErrorMsgEntity(
              errorCode: result.status, errorMsg: "Request Error"));
        }
      } else {
        error(ErrorMsgEntity(
            errorCode: -1,
            errorMsg:
            GmLocalization.of(GlobalApplicationContext.applicationContext)
                .netError));
      }
    } on DioError catch (e) {
      error(createErrorEntity(e));
    }
  }
}
