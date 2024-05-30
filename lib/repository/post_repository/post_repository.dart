import 'dart:developer';

import 'package:crud_api/local_storage/local_storage.dart';
import 'package:crud_api/model/posts_model.dart';
import 'package:crud_api/utils/url.dart';
import 'package:dio/dio.dart';

import '../../data/network/api_service.dart';

class PostRepository{

  Dio dio = Api().dio;
  List<PostModel> postList = [];

  Future<List<PostModel>> getPostApi() async {
    try {
      final  response = await dio.get(AppURL.postsUrl);
      log("response==>${response.data}");
      if (response.statusCode == 200) {

        final postList = PostModel.fromJsonList(response.data);
         await LocalStorage.setPosts(postList);
        return postList;
      }
    } on DioException catch (e) {
      throw Exception(e.response.toString());
    }
    return [] as List<PostModel>;
  }

  Future<void> deletePostApi(var id) async {
    try {
      final Response response = await dio.delete("${AppURL.postsUrl}/$id");
      log("response==>${response.statusCode}");
      if (response.statusCode == 200) {

  LocalStorage.getPost().then((value){
    postList = value!;
          for(int i =0; i<postList.length; i++) {
              postList.remove(value[i]);


          }
        });


      }
    } on DioException catch (e) {
      throw Exception(e.response.toString());
    }

  }
}