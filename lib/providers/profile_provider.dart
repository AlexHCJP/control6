import 'package:control6/models/profile_model.dart';
import 'package:control6/services/api_service.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends InheritedWidget {
  const ProfileProvider({
    super.key,
    required super.child,
    required this.profile,
    required this.login,
    required this.update,
  });

  final ProfileModel? profile;
  final Future<void> Function(String email) login;
  final Future<void> Function(String email, String firstName, String lastName)
  update;

  static ProfileProvider of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<ProfileProvider>();
    if (result == null) return result!;
    throw Exception();
  }

  @override
  bool updateShouldNotify(ProfileProvider oldWidget) {
    return profile != oldWidget.profile;
  }
}

