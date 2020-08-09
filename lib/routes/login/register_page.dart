import 'package:android_flutter_app/common/global.dart';
import 'package:android_flutter_app/common/utils.dart';
import 'package:android_flutter_app/config/api_url.dart';
import 'package:android_flutter_app/config/router_name_config.dart';
import 'package:android_flutter_app/dio/dio_manager.dart';
import 'package:android_flutter_app/dio/request_method.dart';
import 'package:android_flutter_app/l10n/localization_intl.dart';
import 'package:android_flutter_app/models/user_entity.dart';
import 'package:android_flutter_app/widgets/anim/anim_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  ///控制密码是否显示
  bool _pwdShow = false;
  bool _pwdConfirmShow = false;
  String _account = "";
  String _password = "";
  String _rePassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: LoginBackground()),
          Positioned.fill(child: _registerBody()),
        ],
      ),
    );
  }

  _registerBody() {
    return Center(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            color: Colors.white,
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: _registerContent(),
            ),
          ),
        ),
      ),
    );
  }

  _registerContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image(
          image: AssetImage("images/register_icon.png"),
          alignment: Alignment.center,
          width: 60,
          height: 60,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        _generatedTextField(true, false),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        _generatedTextField(false, false),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        _generatedTextField(false, true),
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        _registerBtn(),
      ],
    );
  }

  _generatedTextField(isName, isConfirmPwd) {
    GmLocalization gm = GmLocalization.of(context);
    return TextField(
      decoration: InputDecoration(
        hintText: isName
            ? gm.inputNameHint
            : (isConfirmPwd ? gm.inputConfirmPwdHint : gm.inputPwdHint),
        prefixIcon: Icon(isName ? Icons.person : Icons.lock),
        suffixIcon: isName
            ? null
            : IconButton(
                icon: Icon((isConfirmPwd ? _pwdConfirmShow : _pwdShow)
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () {
                  setState(() {
                    if (isConfirmPwd) {
                      _pwdConfirmShow = !_pwdConfirmShow;
                    } else {
                      _pwdShow = !_pwdShow;
                    }
                  });
                },
              ),
      ),
      obscureText: isName ? false : (isConfirmPwd ? _pwdConfirmShow : _pwdShow),
      maxLength: isName ? 12 : 20,
      keyboardType: TextInputType.visiblePassword,
      onChanged: (v) {
        if (isName) {
          _account = v;
        } else if (isConfirmPwd) {
          _rePassword = v;
        } else {
          _password = v;
        }
      },
    );
  }

  _registerBtn() {
    GmLocalization gm = GmLocalization.of(context);
    return ConstrainedBox(
        constraints: BoxConstraints.expand(height: 50),
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          onPressed: _register,
          textColor: Colors.white,
          child: Text(gm.register),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ));
  }

  _register() {
    //防止有时候出现键盘不自动关闭情况
    FocusScope.of(context).requestFocus(FocusNode());
    GmLocalization gm = GmLocalization.of(context);
    if (_account.isEmpty) {
      showToast(gm.inputNameHint);
      return;
    }
    if (_password.isEmpty) {
      showToast(gm.inputPwdHint);
      return;
    }
    if (_rePassword.isEmpty) {
      showToast(gm.inputConfirmPwdHint);
      return;
    }
    if (_password != _rePassword) {
      showToast(gm.confirmPwdError);
      return;
    }

    showLoading(context);
    DioManager.getInstance().request<UserEntity>(RequestMethod.POST, ApiUrl.getInstance().register, params: {
      "username": _account,
      "password": _password,
      "repassword": _rePassword,
    }, success: (data) {
      //取消对话框
      Navigator.of(context).pop();
       //这里对UserModel没有做数据共享处理
      Global.profile.user  = data;
      Global.saveProfile();
      //跳转到首页
      _goToMainPage();
    }, error: (error) {
      Navigator.of(context).pop();
      showToast(error.errorMsg);
    });
  }

  _goToMainPage(){
    startPageAndFinishCurrentPage(context, RouterNameConfig.MAIN_NAME);
  }
}
