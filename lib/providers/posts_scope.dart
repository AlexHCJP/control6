import 'package:control6/models/post_model.dart';
import 'package:control6/providers/profile_provider.dart';
import 'package:control6/providers/profile_scope.dart';
import 'package:control6/services/api_service.dart';
import 'package:flutter/cupertino.dart';

import 'posts_provider.dart';

class PostScope extends StatefulWidget {
  final Widget child;

  const PostScope({super.key, required this.child});

  @override
  State<PostScope> createState() => _PostScopeState();
}

class _PostScopeState extends State<PostScope> {
  List<PostModel> posts = [];
  DateTime? dateTime;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(ProfileProvider.of(context).profile == null) {
      _clear();
    }
  }

  Future<void> getMessage() async {
    final String? email = ProfileProvider.of(context).profile?.email;

    if (email == null) return;

    posts = await ApiService().getPosts(email);
    dateTime = posts.lastOrNull?.dateTime;
    setState(() {});
  }

  Future<void> getPostsByDateTime() async {
    final String? email = ProfileProvider.of(context).profile?.email;

    if (email == null) return;


    if(dateTime == null) return getMessage();

    final newPosts = await ApiService().getPostsByDateTime(email, dateTime!);

    posts = [...posts, ...newPosts];
    dateTime = posts.lastOrNull?.dateTime;
    setState(() {});
  }

  Future<void> createPost(String message) async {
    final String? email = ProfileProvider.of(context).profile?.email;

    if (email == null) return;

    await ApiService().createPost(email, message);
  }


  void _clear() {
    posts = [];
    dateTime = null;
  }

  @override
  Widget build(BuildContext context) {
    return PostsProvider(
      posts: posts,
      getPosts: getMessage,
      getPostsByDateTime: getPostsByDateTime,
      createPost: createPost,
      child: widget.child,
    );
  }
}
