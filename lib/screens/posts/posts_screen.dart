
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/posts_bloc.dart';
import 'components/posts_body.dart';


class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
 // late PostsBloc _postsBloc;

  @override
  void initState() {
    super.initState();
    // _postsBloc = PostsBloc();
    context.read<PostsBloc>().add(Posts());
   }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _postsBloc.close();
  // }

  @override
  Widget build(BuildContext context) {
    return
     //  BlocProvider(
     // create: (context) => _postsBloc..add(Posts()),
     //  lazy: false,
     //  child:
      Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Posts"),
            centerTitle: true,
          ),
          body: const PostsBody(),
   // )
    );
  }
}
