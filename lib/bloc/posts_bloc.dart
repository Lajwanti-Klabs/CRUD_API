import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:crud_api/local_storage/local_storage.dart';
import 'package:equatable/equatable.dart';
import '../model/posts_model.dart';
import '../repository/post_repository/post_repository.dart';
import '../utils/status.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostEvent, PostsStates> {
  List<PostModel> tempPostList = [];
  PostRepository postRepository = PostRepository();
  PostsBloc() : super(const PostsStates()) {
    on<Posts>(getPosts);
    on<PostDeleted>(deletePosts);
    on<PostUpdated>(updatePost);
  }

  Future<void> getPosts(Posts event, Emitter<PostsStates> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      tempPostList = await postRepository.getPostApi();

      emit(state.copyWith(status: Status.postComplete,postList: List.from(tempPostList)));
    } catch (e) {
      log("post model error: $e");
      emit(state.copyWith(message: e.toString()));
    }
  }

  Future<void> deletePosts(PostDeleted event, Emitter<PostsStates> emit) async {
    try {
      tempPostList = (await LocalStorage.getPost())!;
      tempPostList.removeWhere((e) => e.id == event.id);
      await LocalStorage.setPosts(tempPostList);
      final list = (await LocalStorage.getPost())!;
      emit(state.copyWith(status: Status.complete, postList: list));
      log("type==>${tempPostList.runtimeType.toString()}");
    } catch (e) {
      log("post model error: $e");
      emit(state.copyWith(status: Status.error, message: e.toString()));
    }
  }

  Future<void>updatePost(PostUpdated event, Emitter<PostsStates>emit)async{
    try{
      tempPostList = (await LocalStorage.getPost())!;
      for(var i in tempPostList){
        if(i.id== event.id){
          i.title = event.title.toString();
          await LocalStorage.setPosts(tempPostList);
          final list = (await LocalStorage.getPost())!;
          emit(state.copyWith(status: Status.postUpdate, postList: list));
        }
      }
    }
   catch(e){
     log("post model error: $e");
     emit(state.copyWith(status: Status.error, message: e.toString()));
   }
  }
}
