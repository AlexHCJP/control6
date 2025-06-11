import 'package:flutter/cupertino.dart';

import '../models/post_model.dart';

class PostsProvider extends InheritedWidget {
  const PostsProvider({
    super.key,
    required super.child,
    required this.posts,
    required this.getPosts,
    required this.getPostsByDateTime,
    required this.createPost,
  });

  final List<PostModel> posts;
  final Future<void> Function() getPosts;
  final Future<void> Function() getPostsByDateTime;
  final Future<void> Function(String) createPost;


  static PostsProvider of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<PostsProvider>();
    if (result != null) return result;
    throw Exception();
  }

  @override
  bool updateShouldNotify(PostsProvider oldWidget) {
    return posts != oldWidget.posts;
  }
}
