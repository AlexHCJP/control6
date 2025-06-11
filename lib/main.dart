import 'package:control6/providers/posts_scope.dart';
import 'package:control6/providers/profile_scope.dart';
import 'package:control6/screens/auth_screen.dart';
import 'package:control6/screens/posts_screen.dart';
import 'package:control6/screens/subscribe_screen.dart';
import 'package:control6/screens/update_screen.dart';
import 'package:flutter/material.dart';

import 'core/routing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScope(
      child: PostScope(
        child: MaterialApp(
          initialRoute: AppRoutes.auth,
          routes: {
            AppRoutes.auth: (context) => AuthScreen(),
            AppRoutes.posts: (context) => PostScreen(),
            AppRoutes.updateProfile: (context) => UpdateScreen(),
            AppRoutes.subscribe: (context) => SubscribeScreen(),
          },
        ),
      ),
    );
  }
}

