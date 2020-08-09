import 'dart:convert';

import 'package:android_flutter_app/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailWebView extends StatefulWidget {
  @override
  _DetailWebViewState createState() {
    return _DetailWebViewState();
  }
}

class _DetailWebViewState extends State<DetailWebView> {
  var _isLoading = true;

  @override
  Widget build(BuildContext context) {
    var args = jsonDecode(ModalRoute.of(context).settings.arguments);
    var url = args["url"];

    return Scaffold(
      appBar: AppBar(
        title: Text(args["title"]),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: url,
            //JS运行模式
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: _onPageFinished,
          ),
          Visibility(
            visible: _isLoading,
            child: Center(
              child: CircularProgressIndicator(strokeWidth: 2.0,),
            ),
          )
        ],
      ),
    );
  }

  void _onPageFinished(s) {
    setState(() {
      _isLoading = false;
    });
  }
}
