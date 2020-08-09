import 'package:flutter/cupertino.dart';

class GlobalApplicationContext {
  static BuildContext _applicationContext;

  static get applicationContext {
    return _applicationContext;
  }

  static init(BuildContext context) {
    _applicationContext = context;
  }
}
