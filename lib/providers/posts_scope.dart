import 'package:control6/models/post_model.dart';
import 'package:control6/providers/profile_scope.dart';
import 'package:control6/services/api_service.dart';
import 'package:control6/states/profile_state.dart';
import 'package:flutter/cupertino.dart';

abstract class PostScopeState {
  List<PostModel> posts = [];
  DateTime? dateTime;

  Future<void> getPosts();

  Future<void> getPostsByDateTime();

  Future<void> createPost(String message);
}

class PostScope extends StatefulWidget {
  final Widget Function(BuildContext) builder;

  const PostScope({super.key, required this.builder});

  static PostScopeState of(BuildContext context) {
    return context.findAncestorStateOfType<_PostScopeState>() as PostScopeState;
  }

  @override
  State<PostScope> createState() => _PostScopeState();
}

class _PostScopeState extends State<PostScope> implements  PostScopeState {

  @override
  List<PostModel> posts = [];

  @override
  DateTime? dateTime;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(ProfileScope.of(context).state is! ProfileLoadedState) {
      _clear();
    }
  }

  @override
  Future<void> getPosts() async {
    if(ProfileScope.of(context).state case ProfileLoadedState state) {
      posts = await ApiService().getPosts(state.profile.email);
      dateTime = posts.lastOrNull?.dateTime;
      setState(() {});
    }
  }

  @override
  Future<void> getPostsByDateTime() async {
    if(ProfileScope.of(context).state case ProfileLoadedState state) {
      if(dateTime == null) return getPosts();

      final newPosts = await ApiService().getPostsByDateTime(state.profile.email, dateTime!);

      posts = [...posts, ...newPosts];
      dateTime = posts.lastOrNull?.dateTime;
      setState(() {});
    }
  }

  @override
  Future<void> createPost(String message) async {
    if(ProfileScope.of(context).state case ProfileLoadedState state) {
      await ApiService().createPost(state.profile.email, message);
    }
  }


  void _clear() {
    posts = [];
    dateTime = null;
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);
}
