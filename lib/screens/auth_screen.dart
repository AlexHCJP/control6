import 'package:control6/states/profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/routing.dart';
import '../providers/profile_scope.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _login() async {
    if (_controller.value.text.isEmpty) return;

    try {
      await ProfileScope.of(context).login(_controller.value.text);
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(AppRoutes.posts);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Авторизация')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            TextField(controller: _controller),
            Builder(
              builder: (context) {
                final state = ProfileScope.of(context).state;
                return switch (state) {
                  ProfileInitialState() ||
                  ProfileExceptionState() ||
                  ProfileLoadedState() => ElevatedButton(
                    onPressed: _login,
                    child: Text('Войти'),
                  ),
                  ProfileLoadingState() => ElevatedButton(
                    onPressed: () {},
                    child: CupertinoActivityIndicator(),
                  ),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
