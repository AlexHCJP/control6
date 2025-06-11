import 'dart:async';

import 'package:control6/core/routing.dart';
import 'package:control6/providers/posts_provider.dart';
import 'package:control6/providers/profile_provider.dart';
import 'package:control6/widgets/post_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late final TextEditingController _controller;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    PostsProvider.of(context).getPosts();
    _initialTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _initialTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      PostsProvider.of(context).getPostsByDateTime();
    });
  }

  void _subscribe() {
    Navigator.of(context).pushNamed(AppRoutes.subscribe);
  }

  void _send() {
    if(_controller.value.text.isEmpty) return;

    try {
      PostsProvider.of(context).createPost(_controller.value.text);
      _controller.clear();
    } catch(err) {
      print(err);
    }
  }

  void _update() {
    Navigator.of(context).pushNamed(AppRoutes.updateProfile);
  }

  void _logout() {
    ProfileProvider.of(context).logout();
    Navigator.of(context).pushReplacementNamed(AppRoutes.auth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: _logout,
        ),
        title: Text('Посты'),
        actions: [
          IconButton(onPressed: _subscribe, icon: Icon(Icons.person_add)),
          IconButton(onPressed: _update, icon: Icon(Icons.update)),
        ],
      ),
      body: Column(
        children: [
          Text(ProfileProvider.of(context).profile?.firstName ?? ''),
          Text(ProfileProvider.of(context).profile?.lastName ?? ''),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: PostsProvider.of(context).posts.length,
              itemBuilder: (context, index) {
                final post = PostsProvider.of(context).posts[index];
                return PostCardWidget(post: post);
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.grey.shade200,
        padding: EdgeInsets.all(16),
        child: SafeArea(
          top: false,
          child: Row(
            spacing: 16,
            children: [
              Expanded(child: TextField(controller: _controller)),
              IconButton(onPressed: _send, icon: Icon(Icons.send)),
            ],
          ),
        ),
      ),
    );
  }
}
