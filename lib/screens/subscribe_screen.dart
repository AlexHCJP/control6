import 'package:control6/providers/profile_provider.dart';
import 'package:control6/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/routing.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
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

  void _subscribe() async {
    final email = ProfileProvider.of(context).profile?.email;

    if(email == null) return;


    try {
      await ApiService().subscribe(email, _controller.value.text);
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Подписаться')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            TextField(controller: _controller),
            ElevatedButton(onPressed: _subscribe, child: Text('Подписаться')),
          ],
        ),
      ),
    );
  }
}
