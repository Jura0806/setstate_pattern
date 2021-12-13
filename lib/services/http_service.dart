
import 'dart:convert';
import 'package:http/http.dart';
import 'package:setstate_pattern/models/post_model.dart';

class Network{

  static String BASE = "jsonplaceholder.typicode.com";
  static Map<String, String> headers = {'Content-Type':'application/json; charset=UTF-8'};

  // http APIs //

  static String API_List = "/posts";
  static String API_Create = "/posts";
  static String API_Update = "/posts/"; //{id}
  static String API_Delete = "/posts/";  //{id}

  // http requests //

  static Future<String> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers );
    if(response.statusCode == 200){
      return response.body;
    }
    return 'Request failed with status: ${response.statusCode}.';
  }

  static Future<String> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response = await post(uri, headers:headers, body: jsonEncode(params) );
    if(response.statusCode == 200 || response.statusCode == 201){
      return response.body;
    }
    return 'Request failed with status: ${response.statusCode}.';
  }

  static Future<String> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response = await put(uri, headers:headers, body: jsonEncode(params));
    if(response.statusCode == 200){
      return response.body;
    }
    return 'Request failed with status: ${response.statusCode}.';
  }

  static Future<String> Del(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response = await delete(uri, headers: headers );
    if(response.statusCode == 200){
      return response.body;
    }
    return 'Request failed with status: ${response.statusCode}.';
  }

  // http Params //

  static Map<String, String>  paramsEmpty(){
    Map<String, String> params = new Map();
    return params;
  }

  static Map<String,String> paramsCreate(Post post){
    Map<String, String> params = new Map();
    params.addAll({
      "title": post.title,
      "body": post.body,
      "userId": post.userId.toString(),
    });
    return params;
  }

  static Map<String,String> paramsUpdate(Post post){
    Map<String, String> params = new Map();
    params.addAll({
      "id" : post.id.toString(),
      "title": post.title,
      "body": post.body,
      "userId": post.userId.toString(),
    });
    return params;
  }

  static List<Post> parsePostList(String response){
  dynamic json = jsonDecode(response);
  var data = List<Post>.from(json.map((x) => Post.fromJson(x)));
  return data;
  }
}