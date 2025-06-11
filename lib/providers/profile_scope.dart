

import 'package:control6/providers/profile_provider.dart';
import 'package:flutter/cupertino.dart';

import '../models/profile_model.dart';
import '../services/api_service.dart';

class ProfileScope extends StatefulWidget {
  final Widget child;

  const ProfileScope({super.key, required this.child});

  @override
  State<ProfileScope> createState() => _ProfileScopeState();
}

class _ProfileScopeState extends State<ProfileScope> {
  ProfileModel? profile;

  Future<void> login(String email) async {
    profile = await ApiService().getProfile(email);
    setState(() {});
  }

  Future<void> update(String email, String firstName, String lastName) async {
    profile = await ApiService().updateProfile(email, firstName, lastName);
    setState(() {});
  }


  void logout() {
    profile = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ProfileProvider(
      logout: logout,
      profile: profile,
      login: login,
      update: update,
      child: widget.child,
    );
  }
}