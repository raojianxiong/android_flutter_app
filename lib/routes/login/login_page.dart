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
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  //密码是否显示明文
  bool pwdShow = false;
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后焦点定位到输入框
    _nameController.text = Global.profile.lastLogin;
    //竖屏只在android上有用,兼容IOS的话可以用 https://pub.dartlang.org/packages/orientation
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalization.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: LoginBackground()),
          Positioned.fill(child: LoginAnimWidget(30)),
          Positioned.fill(child: _centerLoginInput(gm)),
        ],
      ),
    );
  }

  _centerLoginInput(GmLocalization gm) {
    return Center(
      //安全区域
      child: SafeArea(
        child: SingleChildScrollView(
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            color: Colors.white,
            margin: EdgeInsets.only(left: 30.0, right: 30.0),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 30),
              child: Form(
                key: _formKey,
                autovalidate: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image(
                      image: AssetImage("images/login_icon.png"),
                      alignment: Alignment.center,
                      width: 60,
                      height: 60,
                    ),
                    _getNameField(gm, true),
                    _getNameField(gm, false),
                    _loginButton(gm),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: FlatButton.icon(
                        highlightColor: Colors.blue[700],
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Text(
                          gm.register,
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: _goToRegister,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loginButton(GmLocalization gm) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(height: 50),
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          onPressed: _loginIn,
          textColor: Colors.white,
          child: Text(gm.login),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }

  _getNameField(GmLocalization gm, var isUserName) {
    return TextFormField(
      controller: isUserName ? _nameController : _pwdController,
      decoration: InputDecoration(
        labelText: isUserName ? gm.userName : gm.password,
        hintText: isUserName ? gm.userName : gm.password,
        prefixIcon: isUserName ? Icon(Icons.person) : Icon(Icons.lock),
        suffixIcon: isUserName
            ? null
            : IconButton(
                icon: Icon(pwdShow ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    pwdShow = !pwdShow;
                  });
                },
              ),
      ),
      obscureText: isUserName ? false : pwdShow,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        return value.isEmpty
            ? (isUserName ? gm.userNameRequired : gm.passwordRequired)
            : null;
      },
      onChanged: (v) {
        (_formKey.currentState as FormState).validate();
      },
    );
  }

  _loginIn() {
    //提交前验证表单字段
    if ((_formKey.currentState as FormState).validate()) {
      //防止有时候出现键盘不自动关闭情况
      FocusScope.of(context).requestFocus(FocusNode());

      showLoading(context);
      //网络请求
      DioManager.getInstance().request<UserEntity>(RequestMethod.POST, ApiUrl.getInstance().login,
          params: {
            "username": _nameController.text,
            "password": _pwdController.text
          }, success: (data) {
        //取消对话框
        Navigator.of(context).pop();
        showToast(GmLocalization.of(context).loginSuccess);
        //这里对UserModel没有做数据共享处理
        Global.profile.user  = data;
        Global.saveProfile();

        _goToMainPage();
        //{"data":{"admin":false,"chapterTops":[],"coinCount":0,"collectIds":[],"email":"","icon":"","id":72181,"nickname":"rjx","password":"","publicName":"rjx","token":"","type":0,"username":"rjx"},"errorCode":0,"errorMsg":""}
      }, error: (error) {
        Navigator.of(context).pop();
        showToast(error.errorMsg);
      });
    }
  }

  _goToMainPage(){
    startPageAndFinishCurrentPage(context, RouterNameConfig.MAIN_NAME);
  }

  _goToRegister() {
    startPageOnly(context,RouterNameConfig.REGISTER_NAME);
  }
}
