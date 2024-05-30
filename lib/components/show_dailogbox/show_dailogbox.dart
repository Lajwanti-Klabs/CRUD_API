import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/posts_bloc.dart';

void showAlert(BuildContext context, String txt, int id) {
  TextEditingController controller = TextEditingController();
  controller.text = txt.toString();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Colors.green.shade50,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: "Update post",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green.shade100, width: 2.0),
                      )),
                ),
                const SizedBox(
                  height: 50,
                ),
                BlocBuilder<PostsBloc, PostsStates>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        context.read<PostsBloc>().add(PostUpdated(
                            title: controller.text,
                            id: id));
                        controller.clear();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Update", style: TextStyle(color: Colors.green),),
                    );
                  },
                )
              ],
            )
        );
      });
}



