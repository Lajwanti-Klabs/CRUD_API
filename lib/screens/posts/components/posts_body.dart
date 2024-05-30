import 'package:crud_api/components/flushbar/flushbar.dart';
import 'package:crud_api/components/show_dailogbox/show_dailogbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/posts_bloc.dart';
import '../../../utils/status.dart';

class PostsBody extends StatelessWidget {
  const PostsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostsBloc, PostsStates>(
        listenWhen: (current, previous) =>
            current.postList.length != previous.postList.length,
        listener: (context, state) {
          if (state.status == Status.error) {
            context.flushBarSuccessMessage(message: state.message.toString());
          }

          if (state.status == Status.complete) {
            context.flushBarSuccessMessage(message: "Post Deleted");
          }

          if (state.status == Status.postUpdate) {
            context.flushBarSuccessMessage(message: "Post Updated");
          }
        },
        child: BlocBuilder<PostsBloc, PostsStates>(builder: (context, state) {
          final posts = state.postList;
          if (state.status == Status.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green.shade100,
              ),
            );
          } else if (state.status == Status.error) {
            return Text(state.message.toString());
          } else if (state.postList.isEmpty) {
            return const Center(
              child: Text("No posts found"),
            );
          }
          return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                          "${posts[index].id.toString()} ${posts[index].title.toString()}"),
                      subtitle: Text(posts[index].body.toString()),
                      trailing: SizedBox(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                                onTap: () {
                                  showAlert(
                                      context,
                                      posts[index].title.toString(),
                                      posts[index].id ?? 0);
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                )),
                            InkWell(
                                onTap: () {
                                  context.read<PostsBloc>().add(
                                      PostDeleted(id: posts[index].id ?? 0));
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                      ),
                    ));
              });
        }));
  }
}
