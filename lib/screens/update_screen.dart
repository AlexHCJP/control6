import 'package:control6/providers/profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/routing.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _firstNameController.value = TextEditingValue(
        text: ProfileProvider.of(context).profile?.firstName ?? '',
      );
      _lastNameController.value = TextEditingValue(
        text: ProfileProvider.of(context).profile?.lastName ?? '',
      );
    });


  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _update() async {
    final email = ProfileProvider.of(context).profile?.email;

    if(email == null) return;

    try {
      await ProfileProvider.of(context).update(
        email,
        _firstNameController.value.text,
        _lastNameController.value.text,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Изменить профиль')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            TextField(controller: _firstNameController),
            TextField(controller: _lastNameController),
            ElevatedButton(onPressed: _update, child: Text('Изменить')),
          ],
        ),
      ),
    );
  }
}
