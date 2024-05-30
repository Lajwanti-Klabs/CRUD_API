
import 'dart:convert';
import 'dart:developer';

import 'package:crud_api/model/posts_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{

LocalStorage._();
static const String _postDataKey = 'postData';
  static Future<void> setPosts(List<PostModel> post)async{
      try {
      final prefs = await SharedPreferences.getInstance();
      final postDataJson = post.toList();

      await prefs.setString(_postDataKey, jsonEncode(postDataJson));
    } catch (e) {
      log("error in setPostData : ${e.toString()}");
    }

  }
static Future<List<PostModel>?> getPost() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final postData = prefs.getString(_postDataKey);
    log("post data==>$postData");

    if (postData != null) {
      final postDataJson = jsonDecode(postData);
      return PostModel.fromJsonList(postDataJson);
    }
    return null;
  } catch (e) {
    log("error in getPostData: ${e.toString()}");
  }
  return null;
}

static Future<bool?> removePosts(String id) async {
  final prefs = await SharedPreferences.getInstance();
   await prefs.remove(id);

  return true;
}
}