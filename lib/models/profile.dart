import 'package:android_flutter_app/generated/json/base/json_convert_content.dart';
import 'package:android_flutter_app/models/user_entity.dart';

class Profile {
  Profile({this.user, this.token, this.theme, this.lastLogin, this.locale});

  UserEntity user;
  String token;
  num theme;
  String lastLogin;
  String locale;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      user: JsonConvert.fromJsonAsT<UserEntity>(json["user"]),
      token: json["token"],
      theme: json["theme"] as num,
      lastLogin: json["lastLogin"],
      locale: json["locale"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": this.user == null ? "" : this.user.toJson(),
      "token": this.token,
      "theme": this.theme,
      "lastLogin": this.lastLogin,
      "locale": this.locale,
    };
  }
}
