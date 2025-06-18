import 'package:flutter/material.dart';

import '../providers/profile_scope.dart';
import '../states/profile_state.dart';

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

    WidgetsBinding.instance.addPostFrameCallback(_setData);
  }

  void _setData(_) {
    if (ProfileScope.of(context).state case ProfileLoadedState state) {
      _firstNameController.value = TextEditingValue(
        text: state.profile.firstName ,
      );
      _lastNameController.value = TextEditingValue(
        text: state.profile.lastName ,
      );
    }

  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _update() async {

    if (ProfileScope.of(context).state case ProfileLoadedState state) {
      try {
        await ProfileScope.of(context).update(
          state.profile.email,
          _firstNameController.value.text,
          _lastNameController.value.text,
        );
        if (!mounted) return;
        Navigator.of(context).pop();
      } catch (err) {
        print(err);
      }
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
