import 'package:flutter/cupertino.dart';

import '../models/profile_model.dart';
import '../services/api_service.dart';
import '../states/profile_state.dart';


abstract class ProfileScopeState {

  ProfileState get state;

  Future<void> update(String email, String firstName, String lastName);

  Future<void> login(String email);

  void logout();
}

class ProfileScope extends StatefulWidget {

  const ProfileScope({super.key, required this.builder});

  final Widget Function(BuildContext) builder;


  static ProfileScopeState of(BuildContext context) {
    return context.findAncestorStateOfType<_ProfileScopeState>() as ProfileScopeState;
  }

  @override
  State<ProfileScope> createState() => _ProfileScopeState();
}

class _ProfileScopeState extends State<ProfileScope> implements ProfileScopeState {
    @override
  ProfileState state = ProfileInitialState();


    void _emit(ProfileState state) {
      setState(() {
        this.state = state;
      });
    }

  @override
  Future<void> login(String email) async {
    _emit(ProfileLoadingState());

    try {
      final response = await ApiService().getProfile(email);
      _emit( ProfileLoadedState(profile: response));
    } catch(err) {
      _emit(ProfileExceptionState());
    }
  }

  @override
  Future<void> update(String email, String firstName, String lastName) async {
    _emit(ProfileLoadingState());
    try {
      final response = await ApiService().updateProfile(email, firstName, lastName);
      _emit(ProfileLoadedState(profile: response));
    } catch(err) {
      _emit(ProfileExceptionState());
    }
  }

  @override
  void logout() {
    _emit(ProfileInitialState());
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);
}