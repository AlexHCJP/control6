import 'package:control6/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostCardWidget extends StatelessWidget {
  final PostModel post;

  const PostCardWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(post.message),
          Text(post.user.email),
        ],
      ),
    );
  }

}