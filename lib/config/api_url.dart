class ApiUrl {
  static ApiUrl _apiUrl;

  static ApiUrl getInstance() {
    if (_apiUrl == null) {
      _apiUrl = ApiUrl();
    }
    return _apiUrl;
  }

  //默认地址
  var baseUrl = "https://www.wanandroid.com/";

  //干货集中营地址
  var gankBaseUrl = "https://gank.io/api/";

  //图片
  var gankGirl = "v2/data/category/Girl/type/Girl/page/%i/count/10";

  //登录
  var login = "user/login";

  //注册
  var register = "user/register";

  //banner
  var banner = "banner/json";

  //首页文章列表
  var articleList = "article/list/%i/json";

  //体系数据
  var treeList = "tree/json";

  //搜索
  var searchList = "article/query/%i/json";

  //热搜
  var hotKeyList = "hotkey/json";

  //常用网站
  var linkList = "friend/json";

  //公众号
  var chapters = "wxarticle/chapters/json";

  //微信列表
  var chaptersList = "wxarticle/list/%i/%i/json";

  //最新项目列表
  var newProjectList = "project/list/%i/json";
}
