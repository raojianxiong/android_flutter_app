import 'package:android_flutter_app/common/global.dart';
import 'package:android_flutter_app/common/utils.dart';
import 'package:android_flutter_app/config/router_name_config.dart';
import 'package:android_flutter_app/dio/dio_manager.dart';
import 'package:android_flutter_app/l10n/localization_intl.dart';
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  _MineStatePage createState() {
    return _MineStatePage();
  }
}

class _MineStatePage extends State<MinePage> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _nickName(),
          //可以抽取出公共方法
          _chapter(),
          _newProject(),
          _picture(),
          _video(),
          _language(),
          _about(),
          _logout(),
        ],
      ),
    );
  }
  _nickName(){
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      constraints: BoxConstraints.expand(height: 160.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.red,Colors.redAccent,Colors.pink],
        ),
      ),
      alignment:  Alignment.center,
      child: Text(Global.profile.user != null ? Global.profile.user.username : "",style: TextStyle(color: Colors.white ,fontSize: 20.0),),
    );
  }
  _newProject(){
    return GestureDetector(
      onTap: (){
        startPageOnly(context, RouterNameConfig.NEW_PROJECT_NAME);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 2),
        padding: EdgeInsets.fromLTRB(15,10,15,10),
        width: double.infinity,
        color: Colors.grey[200],
        child: Row(
          children: <Widget>[
            Icon(Icons.assignment,size: 22,color: Colors.blue,),
            Text(GmLocalization.of(context).newProject,style: TextStyle(fontSize: 16),),
            Expanded(child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 14,),
            ),)
          ],
        ),
      ),
    );
  }

  _chapter(){
    return GestureDetector(
      onTap: (){
        startPageOnly(context,RouterNameConfig.CHAPTER_NAME);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 2),
        padding: EdgeInsets.fromLTRB(15,10,15,10),
        width: double.infinity,
        color: Colors.grey[200],
        child: Row(
          children: <Widget>[
            Icon(Icons.dashboard,size: 22,color: Colors.blue,),
            Text(GmLocalization.of(context).chapter,style: TextStyle(fontSize: 16),),
            Expanded(child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 14,),
            ),)
          ],
        ),
      ),
    );
  }

  _picture(){
    return GestureDetector(
      onTap: (){
        startPageOnly(context, RouterNameConfig.PICTURE_NAME);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 2),
        padding: EdgeInsets.fromLTRB(15,10,15,10),
        width: double.infinity,
        color: Colors.grey[200],
        child: Row(
          children: <Widget>[
            Icon(Icons.picture_in_picture,size: 22,color: Colors.blue,),
            Text(GmLocalization.of(context).welfare,style: TextStyle(fontSize: 16),),
            Expanded(child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 14,),
            ),)
          ],
        ),
      ),
    );
  }

  _video(){
    return GestureDetector(
      onTap: (){
        showToast("waiting....");
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 2),
        padding: EdgeInsets.fromLTRB(15,10,15,10),
        width: double.infinity,
        color: Colors.grey[200],
        child: Row(
          children: <Widget>[
            Icon(Icons.video_call,size: 22,color: Colors.blue,),
            Text(GmLocalization.of(context).casual,style: TextStyle(fontSize: 16),),
            Expanded(child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 14,),
            ),)
          ],
        ),
      ),
    );
  }

  _language(){
    return GestureDetector(
      onTap: (){startPageOnly(context,  RouterNameConfig.SWITCH_LANGUAGE);},
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 2),
        padding: EdgeInsets.fromLTRB(15,10,15,10),
        width: double.infinity,
        color: Colors.grey[200],
        child: Row(
          children: <Widget>[
            Icon(Icons.language,size: 22,color: Colors.blue,),
            Text(GmLocalization.of(context).language,style: TextStyle(fontSize: 16),),
            Expanded(child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 14,),
            ),)
          ],
        ),
      ),
    );
  }

  _about(){
    return GestureDetector(
      onTap: (){
        showToast("waiting....");
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 2),
        padding: EdgeInsets.fromLTRB(15,10,15,10),
        width: double.infinity,
        color: Colors.grey[200],
        child: Row(
          children: <Widget>[
            Icon(Icons.info,size: 22,color: Colors.blue,),
            Text(GmLocalization.of(context).about,style: TextStyle(fontSize: 16),),
            Expanded(child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 14,),
            ),)
          ],
        ),
      ),
    );
  }

  _logout(){
    return GestureDetector(
      onTap: (){_showAlert();},
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 2),
        padding: EdgeInsets.fromLTRB(15,10,15,10),
        width: double.infinity,
        color: Colors.grey[200],
        child: Row(
          children: <Widget>[
            Icon(Icons.exit_to_app,size: 22,color: Colors.blue,),
            Text(GmLocalization.of(context).logout,style: TextStyle(fontSize: 16),),
            Expanded(child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 14,),
            ),)
          ],
        ),
      ),
    );
  }
  AlertDialog mExitDialog ;
  _showAlert(){
    if(mExitDialog == null){
      mExitDialog = AlertDialog(
        content: Text(GmLocalization.of(context).exitHint),
        actions: <Widget>[
          FlatButton(
            child: Text(GmLocalization.of(context).cancel),
            onPressed: ()=>Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text(GmLocalization.of(context).ok),
            onPressed: ()=>Navigator.of(context).pop(true),
          ),
        ],
      );
    }
    Future<bool> exit = showDialog<bool>(context:context,builder: (context){
      return mExitDialog;
    });
    exit.then((value)   {
      if(value){
        Global.profile.user = null;
        Global.saveProfile();
        DioManager.getInstance().cookieJar.deleteAll();
        Navigator.pushNamedAndRemoveUntil(
            context, RouterNameConfig.LOGIN_NAME, (route) => false);
      }
    });
  }
}