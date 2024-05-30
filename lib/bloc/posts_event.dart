part of 'posts_bloc.dart';


abstract class PostEvent extends Equatable{
  const PostEvent();

  @override
  List<Object> get props => [];
}


class Posts extends PostEvent{}
class PostUpdated extends PostEvent{
  final String title;
  final int id;

  const PostUpdated({required this.title,required this.id,});

  @override
  List<Object> get props => [title,id];
}

class PostDeleted extends PostEvent{
 final int id;

  const PostDeleted({required this.id});

  @override
  List<Object> get props => [id];

}
