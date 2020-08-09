import 'package:android_flutter_app/l10n/localization_intl.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessageStatePage createState() {
    return _MessageStatePage();
  }
}

class _MessageStatePage extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(GmLocalization.of(context).messageNotOpen),
    );
  }
}