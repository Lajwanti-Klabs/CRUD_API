part of 'posts_bloc.dart';

class PostsStates extends Equatable {
  final String message;
  final Status status;
  final List<PostModel> postList;


  const PostsStates(
      {this.message = "",
      this.status = Status.loading,
      this.postList = const <PostModel>[],
     });

  PostsStates copyWith(
      {String? message, Status? status, List<PostModel>? postList}) {
    return PostsStates(
      message: message ?? this.message,
      status: status ?? this.status,
      postList: postList ?? this.postList,
    );
  }

  @override
  List<Object?> get props => [message,status,postList];
}
